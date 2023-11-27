import 'package:flutter/material.dart';
import '../models/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  // ThemeData _themeDatas = lightMode;
  // ThemeData get themeDatas => _themeDatas;
  // set themeDatas(ThemeData themeDatas) {
  //   _themeDatas = themeDatas;
  //   notifyListeners();
  // }
  //
  // void toggleTheme() {
  //   _themeDatas == lightMode ? themeDatas = darkMode : themeDatas = lightMode;
  // }

  void followTheSystem() {
    themeMode == ThemeMode.light
        ? themeMode = ThemeMode.system
        : themeMode == ThemeMode.dark
            ? themeMode = ThemeMode.system
            : themeMode = ThemeMode.light;
    notifyListeners();
  }

  void toggleDarkLight() {
    themeMode == ThemeMode.light
        ? themeMode = ThemeMode.dark
        : themeMode = ThemeMode.light;
    notifyListeners();
  }
}
