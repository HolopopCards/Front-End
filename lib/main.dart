import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:holopop/shared/assets/holopop_colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import 'dashboard/screens/dashboard_page.dart';

void main() {
  runApp(const App());
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
          colorScheme: const ColorScheme.dark(),
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(HolopopColors.blue),
              foregroundColor: MaterialStateProperty.all(Colors.white)
            )
          )
        ),
        home: const NavWidget(),
        debugShowCheckedModeBanner: false,
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
  const NavWidget({super.key});

  @override
  State<NavWidget> createState() => HomePage();
}

class HomePage extends State<NavWidget> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0: page = const DashboardPage(); 
      case 1: page = const FavoritesPage(); 
      case 2: page = const Placeholder(); 
      case 3: page = const Placeholder(); 
      default: throw UnimplementedError("no widget for $selectedIndex");
    }

    return Scaffold(
      body: page,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: "Dashboard"
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: "Holopop"
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Create Card"
          ),
          const BottomNavigationBarItem(
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
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<NavState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Column(
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
                label: const Text("Like"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: const Text('Next'),
              ),
            ],
          )
        ]
      );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<NavState>();
    var favorites = appState.favorites;

    if (favorites.isEmpty) {
      return const Center(
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
            leading: const Icon(Icons.favorite), 
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