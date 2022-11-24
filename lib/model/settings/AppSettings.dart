import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../util/UtilMethods.dart';

class AppSettings with ChangeNotifier {
  static final AppSettings _appSettings = AppSettings._internal();

  Future<SharedPreferences> _prefs;
  ThemeMode _themeMode = ThemeMode.light;

  AppSettings._internal() :
    _prefs = SharedPreferences.getInstance() {
    _prefs.then(initializeData);
  }

  factory AppSettings() {
    return _appSettings;
  }

  void initializeData(SharedPreferences prefs) {
    setThemeMode(themeModeFromName(prefs.getString("thememode")) ?? ThemeMode.light);
  }

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;

    notifyListeners();
    _prefs.then((prefs) => prefs.setString("thememode", _themeMode.name));
  }
}
