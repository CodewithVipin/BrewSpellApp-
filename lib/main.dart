import 'package:flutter/material.dart';
import 'package:spelling_improve/screens/home_screen.dart';
import 'theme/coffee_theme.dart';

void main() {
  runApp(const BrewSpellApp());
}

class BrewSpellApp extends StatelessWidget {
  const BrewSpellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrewSpell',
      theme: lightCoffeeTheme,
      darkTheme: darkCoffeeTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),

      debugShowCheckedModeBanner: false,
    );
  }
}
