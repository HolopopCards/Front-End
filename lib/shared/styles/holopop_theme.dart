import 'package:flutter/material.dart';
import 'package:holopop/shared/styles/holopop_colors.dart';

class HolopopTheme {
  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(),
      // INPUT DECORATION
      inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: HolopopColors.darkGrey,
        labelStyle: TextStyle(color: HolopopColors.lightGrey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide.none
        ),
      ),
      // TEXT BUTTON
      textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(HolopopColors.blue),
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          overlayColor: MaterialStatePropertyAll(Colors.blueGrey),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))))
        ),
      ),
      // ELEVATED BUTTON
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(HolopopColors.darkGrey),
          foregroundColor: MaterialStatePropertyAll(Colors.white)
        )
      ),
    );
  }
}