// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:spelling_improve/screens/pack_selection_screen.dart';
import 'package:spelling_improve/utils/sound_player.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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

              // Small isolated widget — animation won't repaint the whole screen
              const CoffeeCup(),

              const SizedBox(height: 25),

              // ---------------- TITLE ----------------
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

              // ---------------- BUTTON ----------------
              Builder(
                builder: (ctx) {
                  return Container(
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
                              ? Colors.black.withOpacity(0.5)
                              : Colors.brown.withOpacity(0.25),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
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
                        SoundPlayer.startquiz();
                        Navigator.push(
                          ctx,
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
                  );
                },
              ),

              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}

/// A small widget that owns its own AnimationController and is isolated by RepaintBoundary.
/// Only this widget repaints during animation frames — the rest of the screen remains untouched.
class CoffeeCup extends StatefulWidget {
  const CoffeeCup({super.key});

  @override
  State<CoffeeCup> createState() => _CoffeeCupState();
}

class _CoffeeCupState extends State<CoffeeCup>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    // keep controller local to this widget
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // a smooth 0..1 animation
    _anim = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // RepaintBoundary makes sure only this subtree repaints on animation frames.
    return RepaintBoundary(
      child: SizedBox(
        height: 160,
        width: 160,
        child: AnimatedBuilder(
          animation: _anim,
          builder: (context, child) {
            // small vertical oscillation (cheap transform)
            final double offsetY = -4 * math.sin(_anim.value * math.pi);
            return Transform.translate(
              offset: Offset(0, offsetY),
              child: child,
            );
          },
          child: Icon(
            Icons.local_cafe_rounded,
            size: 120,
            color: isDark ? Colors.white70 : Colors.brown[700],
          ),
        ),
      ),
    );
  }
}
