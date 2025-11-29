// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:spelling_improve/model/word_entry.dart';
import 'package:spelling_improve/utils/sound_player.dart';
import '../widgets/option_tile.dart';

class QuizScreen extends StatefulWidget {
  final WordPack wordPack;

  const QuizScreen({super.key, required this.wordPack});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int index = 0;
  int score = 0;
  bool answered = false;
  String? selected;

  late List<WordEntry> words;
  late List<String> options;

  @override
  void initState() {
    super.initState();

    /// Shuffle and pick ONLY 10 random questions
    words = List.from(widget.wordPack.words)..shuffle();
    words = words.take(10).toList();

    _prepareOptions();
  }

  void _prepareOptions() {
    final w = words[index];
    options = [...w.distractors, w.correct]..shuffle();

    setState(() {
      answered = false;
      selected = null;
    });
  }

  void _select(String choice) {
    if (answered) return;

    bool isCorrect = choice == words[index].correct;

    setState(() {
      selected = choice;
      answered = true;
      if (isCorrect) score++;
    });

    if (isCorrect) {
      SoundPlayer.correct();
    } else {
      SoundPlayer.wrong();
    }
  }

  void _next() {
    if (index < words.length - 1) {
      setState(() => index++);
      _prepareOptions();
    } else {
      _finish();
    }
  }

  void _finish() {
    SoundPlayer.finish();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text(
          "Quiz Completed!",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Your Score: $score / ${words.length}",
          style: const TextStyle(fontSize: 18),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          // Go to Pack Selection
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Exit QuizScreen
              // Navigator.pop(context); // Exit WordPack selection
              // Now home or pack screen will show
            },
            child: const Text("Start Quiz", style: TextStyle(fontSize: 16)),
          ),

          // Retry Same Pack
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              setState(() {
                index = 0;
                score = 0;
                selected = null;
                answered = false;
                words.shuffle();
                _prepareOptions();
              });
            },
            child: const Text("Retry", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final word = words[index];
    final progress = (index + (answered ? 1 : 0)) / words.length;

    // ignore: unused_local_variable
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 60, 16, 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.wordPack.name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  backgroundColor: Colors.white12,
                  valueColor: AlwaysStoppedAnimation(Colors.orangeAccent),
                ),

                const SizedBox(height: 40),

                const Text(
                  "Pick the correct spelling",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                Center(
                  child: Text(
                    "${word.correct[0]}···",
                    style: const TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                ...options.map(
                  (o) => OptionTile(
                    text: o,
                    correct: word.correct,
                    selected: selected == o,
                    answered: answered,
                    onTap: () => _select(o),
                  ),
                ),

                const SizedBox(height: 150),
              ],
            ),
          ),

          // Floating NEXT button
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orangeAccent,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: answered ? _next : null,
              child: Text(
                index < words.length - 1 ? "Next" : "Finish",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
