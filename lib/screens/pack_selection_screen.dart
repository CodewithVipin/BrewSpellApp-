// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import '../data/word_loader.dart';
import 'quiz_screen.dart';

class PackSelectionScreen extends StatelessWidget {
  const PackSelectionScreen({super.key});

  final List<Map<String, String>> packs = const [
    {"title": "Basic Pack", "file": "basic.json", "icon": "🟤"},
    {"title": "Intermediate Pack", "file": "intermediate.json", "icon": "🟫"},
    {"title": "Advanced Pack", "file": "advanced.json", "icon": "⚫"},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Word Pack"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: isDark ? const Color(0xFF1A1A1A) : Colors.brown[100],
      ),

      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [const Color(0xFF1C1C1C), const Color(0xFF101010)]
                : [const Color(0xFFF7EEDB), const Color(0xFFEAD9C4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: ListView.builder(
          itemCount: packs.length,
          itemBuilder: (context, index) {
            final pack = packs[index];

            return _PackCard(
              title: pack["title"]!,
              file: pack["file"]!,
              icon: pack["icon"]!,
            );
          },
        ),
      ),
    );
  }
}

class _PackCard extends StatelessWidget {
  final String title;
  final String file;
  final String icon;

  const _PackCard({
    required this.title,
    required this.file,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () async {
          final pack = await WordLoader.loadPack(file);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => QuizScreen(wordPack: pack)),
          );
        },

        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.brown.withOpacity(0.1),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.15)
                  : Colors.brown.withOpacity(0.3),
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.6)
                    : Colors.brown.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: Row(
            children: [
              // Icon Circle
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isDark
                      ? Colors.white.withOpacity(0.08)
                      : Colors.white.withOpacity(0.7),
                ),
                child: Text(icon, style: const TextStyle(fontSize: 22)),
              ),

              const SizedBox(width: 20),

              // Title + Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.brown[900],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Tap to begin",
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.white54 : Colors.brown[600],
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
