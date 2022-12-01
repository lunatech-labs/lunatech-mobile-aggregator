import 'package:flutter/material.dart';

final lightTheme2 = ThemeData.from(
    colorScheme: const ColorScheme.light(
  primary: Color(0xFF161618),
  secondary: Color(0xFFEA212E),
  tertiary: Color(0xFFA1A6B5),
  background: Color(0xFFF8F9FC),
));

final darkTheme2 = ThemeData.from(
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF161618),
      secondary: Color(0xFFEA212E),
      tertiary: Color(0xFFA1A6B5),
      background: Color(0xFF282b30),
      onBackground: Colors.white,
      surface: Color(0xFF161618),
    ),
    textTheme: Typography.material2021(platform: TargetPlatform.android).white);
