import 'package:flutter/material.dart';

class AppSettings with ChangeNotifier {
  static final AppSettings _appSettings = AppSettings._internal();

  ThemeMode _themeMode;

  AppSettings._internal() : _themeMode = ThemeMode.light;

  factory AppSettings() {
    return _appSettings;
  }

  ThemeMode get themeMode => _themeMode;

  void switchThemeMode() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
