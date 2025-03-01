import 'package:flutter/material.dart';



ThemeData lightMode = ThemeData(
  fontFamily: 'PlusJakartaSans',
  brightness: Brightness.light,
  primaryColor: Colors.deepOrangeAccent,
  primaryColorLight: Colors.orange,
  primaryColorDark: Colors.red,
  colorScheme: ColorScheme.light(
    tertiary: Colors.green,
    error: Colors.blue,
    background: Colors.white,
    primary: Colors.deepOrangeAccent,
    secondary: Colors.red.shade900,
    shadow: const Color.fromRGBO(0, 0, 0, 0.3),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.deepOrangeAccent,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: const TextStyle(color: Colors.white),
    backgroundColor: Colors.white,
    closeIconColor: Colors.deepOrangeAccent,
    showCloseIcon: true,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  dialogTheme: DialogTheme(
    actionsPadding: const EdgeInsets.all(10),
    elevation: 10,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
).copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.deepOrangeAccent,
      foregroundColor: Colors.white,
      elevation: 9,
      fixedSize: const Size(double.infinity, 40),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      side: const BorderSide(color: Colors.deepOrangeAccent, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: TextButton.styleFrom(
      fixedSize: const Size(double.infinity, 30),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      side: const BorderSide(color: Colors.deepOrangeAccent, width: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.deepOrangeAccent.withOpacity(0.2),
      fixedSize: const Size(double.infinity, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.white,
    filled: true,
    isDense: true,
    prefixIconColor: Colors.deepOrangeAccent,
    suffixIconColor: Colors.deepOrangeAccent,
    hintStyle: TextStyle(color: Colors.deepOrangeAccent.withOpacity(0.4)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide.none,
    ),
  ),
  textTheme: const TextTheme(
    labelSmall: TextStyle(
      color: Colors.deepOrangeAccent,
      fontFamily: 'PlusJakartaSans',
    ),
    titleMedium: TextStyle(
      color: Colors.deepOrangeAccent,
      fontWeight: FontWeight.bold,
      fontFamily: 'PlusJakartaSans',
    ),
    headlineSmall: TextStyle(
      color: Colors.deepOrangeAccent,
      fontWeight: FontWeight.w900,
      fontFamily: 'PlusJakartaSans',
    ),
  ),
);

ThemeData darkMode = ThemeData(
  fontFamily: 'PlusJakartaSans',
  brightness: Brightness.dark,
  primaryColor: Colors.deepOrangeAccent,
  primaryColorLight: Colors.orange,
  primaryColorDark: Colors.red,
  colorScheme: ColorScheme.dark(
    tertiary: Colors.greenAccent,
    error: Colors.red,
    background: Colors.black,
    primary: Colors.deepOrangeAccent.shade400,
    secondary: Colors.red.shade900.withOpacity(0.2),
    shadow: const Color.fromRGBO(19, 19, 19, 0.7725490196078432),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.deepOrangeAccent,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    contentTextStyle: const TextStyle(color: Colors.white),
    backgroundColor: Colors.black,
    closeIconColor: Colors.redAccent,
    showCloseIcon: true,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  ),
  dialogTheme: DialogTheme(
    actionsPadding: const EdgeInsets.all(10),
    elevation: 10,
    backgroundColor: Colors.black,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
).copyWith(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.deepOrangeAccent,
      foregroundColor: Colors.white,
      elevation: 9,
      fixedSize: const Size(double.infinity, 40),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      side: const BorderSide(color: Colors.deepOrangeAccent, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: TextButton.styleFrom(
      fixedSize: const Size(double.infinity, 30),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      side: const BorderSide(color: Colors.deepOrangeAccent, width: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.orange,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: Colors.redAccent.withOpacity(0.2),
      fixedSize: const Size(double.infinity, 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    fillColor: Colors.black,
    filled: true,
    isDense: true,
    prefixIconColor: Colors.deepOrangeAccent,
    suffixIconColor: Colors.deepOrangeAccent,
    hintStyle: TextStyle(color: Colors.deepOrangeAccent.withOpacity(0.4)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(13),
      borderSide: BorderSide.none,
    ),
  ),
  textTheme: const TextTheme(
    labelSmall: TextStyle(
      color: Colors.white,
      fontFamily: 'PlusJakartaSans',
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontFamily: 'PlusJakartaSans',
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w900,
      fontFamily: 'PlusJakartaSans',
    ),
  ),
);
