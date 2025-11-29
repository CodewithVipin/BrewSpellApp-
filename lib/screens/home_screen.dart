// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:spelling_improve/screens/pack_selection_screen.dart';
import 'package:spelling_improve/utils/sound_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _steamController;

  @override
  void initState() {
    super.initState();

    _steamController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _steamController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1F1F1F), const Color(0xFF0F0F0F)]
                : [const Color(0xFFF2E6D9), const Color(0xFFE5D0B5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              /// ----------- ANIMATED COFFEE CUP -------------
              AnimatedBuilder(
                animation: _steamController,
                builder: (_, child) {
                  return Transform.translate(
                    offset: Offset(
                      0,
                      -4 * math.sin(_steamController.value * math.pi),
                    ),
                    child: child,
                  );
                },
                child: Icon(
                  Icons.local_cafe_rounded,
                  size: 120,
                  color: isDark ? Colors.white70 : Colors.brown[700],
                ),
              ),

              const SizedBox(height: 25),

              /// ---------------- TITLE ----------------
              Text(
                "BrewSpell",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : Colors.brown[900],
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Master spelling, one brew at a time",
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? Colors.white70 : Colors.brown[700],
                ),
              ),

              const SizedBox(height: 60),

              /// ---------------- BUTTON ----------------
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.brown.withOpacity(0.1),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.2)
                        : Colors.brown.withOpacity(0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isDark
                          ? Colors.black.withOpacity(0.6)
                          : Colors.brown.withOpacity(0.3),
                      blurRadius: 18,
                      spreadRadius: -2,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    minimumSize: const Size(180, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  onPressed: () async {
                    await SoundPlayer.playStart();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PackSelectionScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Start Quiz",
                    style: TextStyle(
                      fontSize: 20,
                      color: isDark ? Colors.white : Colors.brown[900],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}
