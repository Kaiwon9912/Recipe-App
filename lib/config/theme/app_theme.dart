import 'package:flutter/material.dart';

final ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white70,

    onSurface: Colors.black,
    primary: Color.fromRGBO(208, 164, 4, 1),
    tertiaryContainer: Color.fromRGBO(206, 167, 0, 0.15),
    tertiary: Color.fromRGBO(115, 76, 16, 1),
    secondary: Colors.blue.shade900,
    surfaceBright: Colors.white,
  ),
);
