import 'package:flutter/material.dart';
import 'package:holopop/shared/nav/destination_view.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}


class _HomePage extends State<HomePage> {
  var _currentIndex = 0;
  var _showNavBar   = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
          child: IndexedStack(
            index: _currentIndex,
            children: allDestinations.map((dest) => DestinationView(destination: dest)).toList()
          ),
      ),
      bottomNavigationBar: 
        _showNavBar 
          ? BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (i) { setState(() { _currentIndex = i; }); },
            selectedItemColor: HolopopColors.blue,
            unselectedItemColor: HolopopColors.lightgrey,
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