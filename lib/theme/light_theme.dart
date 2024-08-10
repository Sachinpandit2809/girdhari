import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
    ),
    colorScheme: const ColorScheme.light(
      surface: Color.fromARGB(255, 255, 255, 255),
      primary: Color.fromARGB(255, 60, 59, 59),
      secondary: Color.fromARGB(255, 255, 255, 255),
    ));
