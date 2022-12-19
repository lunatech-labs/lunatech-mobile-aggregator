import 'package:flutter/material.dart';

final lightTheme2 = ThemeData.from(
    colorScheme: const ColorScheme.light(
  primary: Color(0xFF161618),
  secondary: Color(0xFFEA212E),
  tertiary: Color(0xFFA1A6B5),
  background: Color(0xFFF8F9FC),
));

final darkTheme2 = ThemeData.from(
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF161618),
          surface: Color(0xFF161618),
          secondary: Color(0xFFEA212E),
          tertiary: Color(0xFFA1A6B5),
          background: Color(0xFF282b30),
          onSurface: Colors.white,
          onBackground: Colors.white,
        ),
        textTheme:
            Typography.material2021(platform: TargetPlatform.android).white)
    .copyWith(
        textButtonTheme: TextButtonThemeData(
            style:
                TextButton.styleFrom(foregroundColor: const Color(0xFFEA212E))),
        unselectedWidgetColor: Colors.white,
        toggleableActiveColor: const Color(0xFFEA212E)
);
