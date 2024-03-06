import 'package:flutter/material.dart';
import 'package:holopop/login/login_page.dart';
import 'package:holopop/shared/firebase/firebase_utlity.dart';
import 'package:holopop/shared/storage/user_preferences.dart';
import 'package:logging/logging.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: FutureBuilder(
          future: UserPreferences().getUserAsync(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasError) {
                  Logger('home').severe("Error getting user during login page: ${snapshot.error}");
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data?.token == null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Logger('home').fine("No user in storage. Take them to login page.");
                    Navigator.pushNamed(context, "/login");
                  });
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Logger('home').fine("User in storage, take them to dashboard.");
                    Navigator.pushNamed(context, "/dashboard");
                  });
                }
              default: break;
            }

            return const CircularProgressIndicator();
        })));
  }
}

