import 'package:flutter/material.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:flutter/services.dart';

import 'dashboard/screens/dashboard_page.dart';


class Destination {
  const Destination(this.title, this.icon);
  final String title;
  final IconData icon;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Dashboard',   Icons.wallet),
  Destination('Holopop',     Icons.qr_code_scanner),
  Destination('Create Card', Icons.add_circle_outlined),
  Destination('Shop',        Icons.shop)
];


class DestinationView extends StatefulWidget {
  const DestinationView({super.key, required this.destination });

  final Destination destination;

  @override
  State<StatefulWidget> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              default:
                return const DashboardPage();
            }
          },
        );
      },
    );
  }
}


void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack); //Fullscreen
    return MaterialApp(
      title: 'HoloPop',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(HolopopColors.blue),
            foregroundColor: MaterialStateProperty.all(Colors.white)
          )
        )
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: IndexedStack(
          index: _currentIndex,
          children: allDestinations.map((dest) =>
            DestinationView(destination: dest)).toList()
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}