// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../data/word_loader.dart';
import 'quiz_screen.dart';

class PackSelectionScreen extends StatelessWidget {
  const PackSelectionScreen({super.key});

  final List<Map<String, String>> packs = const [
    {"title": "Basic Pack", "file": "basic.json"},
    {"title": "Intermediate Pack", "file": "intermediate.json"},
    {"title": "Advanced Pack", "file": "advanced.json"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Word Pack"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: packs.length,
        itemBuilder: (context, index) {
          final pack = packs[index];
          return ListTile(
            title: Text(pack["title"]!, style: TextStyle(fontSize: 18)),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () async {
              final loadedPack = await WordLoader.loadPack(pack["file"]!);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuizScreen(wordPack: loadedPack),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
