import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool isFirstTime = true;
  bool isInit = false;

  Future<void> getStarted() async {
    isFirstTime = false;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final actualTheme = {'isFirstTime': isFirstTime};
    final themData = json.encode(actualTheme);
    // prefs.setString('themData', themData);
  }

  Future<void> getIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('themData')) {
      return;
    }
    final extractedThemeData =
        json.decode(prefs.getString('themData').toString());
    extractedThemeData['themeMode'] == ThemeMode.light.index
        ? themeMode = ThemeMode.light
        : extractedThemeData['themeMode'] == ThemeMode.dark.index
            ? themeMode = ThemeMode.dark
            : themeMode = ThemeMode.system;
    notifyListeners();
  }

  Future<void> getOut() async {
    final prefs = await SharedPreferences.getInstance();
    final actualTheme = {'themeMode': themeMode.index};
    final themData = json.encode(actualTheme);
    prefs.setString('themData', themData);
  }

  void toggleDarkLight() {
    themeMode == ThemeMode.light
        ? themeMode = ThemeMode.dark
        : themeMode = ThemeMode.light;
    notifyListeners();
  }

  void followTheSystem() {
    if (themeMode != ThemeMode.system) {
      themeMode = ThemeMode.system;
      notifyListeners();
      getOut();
    }
  }

  void setLightTheme() {
    if (themeMode != ThemeMode.light) {
      themeMode = ThemeMode.light;
      notifyListeners();
      getOut();
    }
  }

  void setDarkTheme() {
    if (themeMode != ThemeMode.dark) {
      themeMode = ThemeMode.dark;
      notifyListeners();
      getOut();
    }
  }
}
