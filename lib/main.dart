import 'package:flutter/material.dart';
import 'package:holopop/home_page.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';
import 'package:flutter/services.dart';


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
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(HolopopColors.blue),
            foregroundColor: MaterialStatePropertyAll(Colors.white)
          )
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(HolopopColors.darkgrey),
            foregroundColor: MaterialStatePropertyAll(Colors.white)
          )
        )
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}