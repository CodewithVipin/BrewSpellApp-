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
    Color? bg;
    IconData? icon;

    if (answered) {
      if (selected && text == correct) {
        bg = Colors.green.withOpacity(0.15);
        icon = Icons.check_circle;
      } else if (selected && text != correct) {
        bg = Colors.red.withOpacity(0.15);
        icon = Icons.cancel;
      } else if (text == correct) {
        bg = Colors.green.withOpacity(0.10);
      }
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: bg ?? Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? Theme.of(context).primaryColor : Colors.transparent,
          width: selected ? 2 : 0,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16),
        ),
        trailing: icon == null ? null : Icon(icon),
      ),
    );
  }
}
