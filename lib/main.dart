import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'assets/holopop_colors.dart';
import 'dashboard/screens/dashboard_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack); //Fullscreen

    return ChangeNotifierProvider(
      create: (context) => NavState(),
      child: MaterialApp(
        title: 'HoloPop',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.dark()
        ),
        home: NavWidget(),
      ),
    );
  }
}

class NavState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];
  
  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class NavWidget extends StatefulWidget {
  @override
  State<NavWidget> createState() => HomePage();
}

class HomePage extends State<NavWidget> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0: page = DashboardPage(); 
      case 1: page = FavoritesPage(); 
      case 2: page = Placeholder(); 
      case 3: page = Placeholder(); 
      default: throw UnimplementedError("no widget for $selectedIndex");
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: "Dashboard"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "Holopop"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Create Card"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: "Shop"
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: HolopopColors.blue,
        unselectedItemColor: HolopopColors.lightgrey,
        showUnselectedLabels: true,
        onTap: (i) { 
          setState(() { 
            selectedIndex = i; 
          });
        },
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<NavState>();
    var pair = appState.current;

    var icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: Text("Like"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    appState.getNext();
                  },
                  child: Text('Next'),
                ),
              ],
            )
          ]
        ),
      );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<NavState>();
    var favorites = appState.favorites;

    if (favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet')
      );
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('You have ${favorites.length} favorites: ')
        ),
        for (var f in favorites)
          ListTile(
            leading: Icon(Icons.favorite), 
            title: Text(f.asLowerCase))
      ]
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary
    );

    return Card(
      color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            pair.asLowerCase, 
            style: style,
            semanticsLabel: "${pair.first} ${pair.second}",),
      ),
    );
  }
}