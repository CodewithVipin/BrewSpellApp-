import 'package:flutter/material.dart';

final ThemeData lightCoffeeTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFFFF7F0),
  primaryColor: const Color(0xFF7A4F36),
  cardColor: const Color(0xFFFFF1E6),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      color: Color(0xFF2F1B13),
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(color: Color(0xFF2F1B13)),
  ),
);

final ThemeData darkCoffeeTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF1C1412),
  primaryColor: const Color(0xFFD9A066),
  cardColor: const Color(0xFF251812),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
      color: Color(0xFFF5EDE6),
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(color: Color(0xFFF5EDE6)),
  ),
);
