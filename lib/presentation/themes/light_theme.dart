import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.orange.shade800,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade300,
    background: Colors.grey.shade300,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    elevation: 10,
    backgroundColor: Colors.orange[800],
  ),
);
