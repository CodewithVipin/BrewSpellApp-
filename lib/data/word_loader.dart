import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:spelling_improve/model/word_entry.dart';

class WordLoader {
  static Future<WordPack> loadPack(String filename) async {
    final String data = await rootBundle.loadString(
      "assets/wordpacks/$filename",
    );

    final jsonData = json.decode(data);

    return WordPack.fromJson(jsonData);
  }
}
