import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme:const AppBarTheme(
      backgroundColor: Color.fromARGB(255, 24, 24, 24),
    ),
    colorScheme: const ColorScheme.dark(
      background: Color.fromARGB(255, 24, 24, 24),
      primary: Color.fromARGB(255, 255, 253, 253),
      secondary: Color.fromARGB(255, 75, 74, 74),
    ));
