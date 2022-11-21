import 'package:flutter/material.dart';

final lightTheme = ThemeData(
    backgroundColor: const Color(0xFFF8F9FC),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF161618),
      secondary: Color(0xFFEA212E),
      tertiary: Color(0xFFA1A6B5),
      background: Color(0xFFF8F9FC),
    ));

final darkTheme = _darkTheme();
ThemeData _darkTheme() {
  var dark = ThemeData(
      brightness: Brightness.dark,
      backgroundColor: const Color(0xFF282b30),
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF161618),
        secondary: Color(0xFFEA212E),
        tertiary: Color(0xFFA1A6B5),
        background: Color(0xFF282b30)
      )
  );
  dark.textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white);
  return dark;
}
