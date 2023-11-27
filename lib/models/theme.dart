import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.orange,
  primaryColorLight: Colors.deepOrangeAccent,
  primaryColorDark: Colors.red,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.deepOrangeAccent,
    secondary: Colors.deepOrangeAccent.shade700,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.white,
    closeIconColor: Colors.orange,
    showCloseIcon: true,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  fontFamily: 'PlusJakartaSans',
);
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.grey.shade900,
  primaryColorLight: Colors.black,
  primaryColorDark: Colors.black54,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade300,
    primary: Colors.black26,
    secondary: Colors.black12,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.grey.shade600,
    behavior: SnackBarBehavior.floating,
    closeIconColor: Colors.black,
    showCloseIcon: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  fontFamily: 'PlusJakartaSans',
);
