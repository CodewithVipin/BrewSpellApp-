class WordEntry {
  final String correct;
  final List<String> distractors;

  WordEntry({required this.correct, required this.distractors});

  factory WordEntry.fromJson(Map<String, dynamic> json) {
    return WordEntry(
      correct: json["correct"],
      distractors: List<String>.from(json["distractors"]),
    );
  }
}

class WordPack {
  final String name;
  final List<WordEntry> words;

  WordPack({required this.name, required this.words});

  factory WordPack.fromJson(Map<String, dynamic> json) {
    return WordPack(
      name: json["name"],
      words: (json["words"] as List)
          .map((item) => WordEntry.fromJson(item))
          .toList(),
    );
  }
}
