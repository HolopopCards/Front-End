import 'package:flutter/material.dart';
import 'package:holopop/login/login_page.dart';
import 'package:holopop/shared/firebase/firebase_utlity.dart';
import 'package:holopop/shared/nav/destination_view.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:holopop/shared/storage/user_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}


class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    FirebaseUtility().startFirebaseListening();
  }

  var _currentIndex = 0;
  var _showNavBar   = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: 
          FutureBuilder(
           future: UserPreferences().getUserAsync(),
           builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data?.token == null) {
                  return const LoginPage();
                } else {
                  //TODO: THIS IS A HACK
                  if (_showNavBar == false) {
                    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => _showNavBar = true));
                  }
                  return IndexedStack(
                    index: _currentIndex,
                    children: allDestinations.map((dest) => DestinationView(destination: dest))
                                             .toList());
                }
            }
          },
        ),
      ),
      bottomNavigationBar: 
        _showNavBar 
          ? BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (i) { setState(() { _currentIndex = i; }); },
            selectedItemColor: HolopopColors.blue,
            unselectedItemColor: HolopopColors.lightGrey,
            showUnselectedLabels: true,
            items: allDestinations.map((dest) =>
              BottomNavigationBarItem(
                label: dest.title,
                icon: Icon(dest.icon)
              )).toList()
            )
          : const SizedBox()
    );
  }
}