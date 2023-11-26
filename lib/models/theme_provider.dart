import 'package:flutter/material.dart';
import '../models/theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themeData => _themeData;
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData == lightMode ? themeData = darkMode : themeData = lightMode;
  }
}
