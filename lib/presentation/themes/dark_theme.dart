import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.orange.shade800,
    iconTheme: IconThemeData(color: Colors.orange.shade600),
    titleTextStyle: TextStyle(color: Colors.grey.shade800, fontSize: 20, fontWeight: FontWeight.w700),
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade900,
    secondary: Colors.grey.shade800,
    background: Colors.black.withOpacity(0.2),
  ),
);
