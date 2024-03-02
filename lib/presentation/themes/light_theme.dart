import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    //FIXME - Make a theme that applies to all inputdecorations. main focus here is different borders!
    // inputDecorationTheme: InputDecorationTheme(
    //     contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    //     focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.orange, width: 2.0), borderRadius: BorderRadius.circular(10.0)),
    //     enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 2.0), borderRadius: BorderRadius.circular(10.0))),
    // disabledColor: Colors.grey.shade200,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.orange.shade800,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
    ),
    colorScheme: ColorScheme.light(
      outline: Colors.amberAccent.shade700,
      primary: Colors.orange.shade800,
      // secondary: Colors.orange.shade500,
      // background: Colors.grey.shade300,
    ),
    expansionTileTheme: ExpansionTileThemeData(backgroundColor: Colors.white),
    buttonTheme: ButtonThemeData(colorScheme: ColorScheme.light(primary: Colors.orange.shade800)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 10,
      // foregroundColor: Colors.orange.shade300,
      backgroundColor: Colors.orange.shade300,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.transparent),
      side: MaterialStateProperty.all(const BorderSide(color: Colors.transparent)),
      // surfaceTintColor: MaterialStateProperty.all(Colors.blue),
    )),
    //FIXME - Find a way to assign this them to all Cards
    cardTheme: CardTheme(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black12, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
    ));
