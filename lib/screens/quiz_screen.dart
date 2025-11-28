import 'package:flutter/material.dart';
import 'package:spelling_improve/model/word_entry.dart';
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
    words = List.from(widget.wordPack.words)..shuffle();
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

    setState(() {
      selected = choice;
      answered = true;
      if (choice == words[index].correct) score++;
    });
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
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Quiz Complete"),
        content: Text("Score: $score / ${words.length}"),
        actions: [
          ElevatedButton(
            child: const Text("Close"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final word = words[index];
    final progress = (index + (answered ? 1 : 0)) / words.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.wordPack.name),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LinearProgressIndicator(value: progress),

            const SizedBox(height: 20),
            Text(
              "Pick the correct spelling:",
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),
            Text(
              "${word.correct[0]}···",
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 20),
            ...options.map(
              (o) => OptionTile(
                text: o,
                correct: word.correct,
                selected: selected == o,
                answered: answered,
                onTap: () => _select(o),
              ),
            ),
            const Spacer(),

            ElevatedButton(
              onPressed: answered ? _next : null,
              child: Text(index < words.length - 1 ? "Next" : "Finish"),
            ),
          ],
        ),
      ),
    );
  }
}
