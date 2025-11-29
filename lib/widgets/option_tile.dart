// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String text;
  final String correct;
  final bool selected;
  final bool answered;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.text,
    required this.correct,
    required this.selected,
    required this.answered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isCorrect = text == correct;
    bool isWrong = selected && !isCorrect;

    Color baseColor = const Color(0xFF1A1A1A);
    Color borderColor = Colors.transparent;

    if (answered) {
      if (isCorrect) borderColor = Colors.greenAccent;
      if (isWrong) borderColor = Colors.redAccent;
    } else if (selected) {
      borderColor = Colors.orangeAccent;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          if (selected && !answered)
            BoxShadow(
              color: Colors.orangeAccent.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          if (answered && isCorrect)
            BoxShadow(
              color: Colors.greenAccent.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          if (answered && isWrong)
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(fontSize: 18, color: Colors.white70),
              ),
            ),

            if (answered && isCorrect)
              const Icon(Icons.check_circle, color: Colors.greenAccent),

            if (answered && isWrong)
              const Icon(Icons.cancel, color: Colors.redAccent),
          ],
        ),
      ),
    );
  }
}
