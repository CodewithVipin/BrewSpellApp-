import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

class SoundPlayer {
  static final AudioPlayer _player = AudioPlayer();

  static bool _loaded = false;

  // Byte buffers for all sounds
  static late Uint8List correctBytes;
  static late Uint8List wrongBytes;
  static late Uint8List startquizBytes;
  static late Uint8List finishBytes;
  static late Uint8List welcomeBytes;

  // ---------- PRELOAD ALL SOUNDS (FASTEST SYSTEM) ----------
  static Future<void> preload() async {
    if (_loaded) return;
    _loaded = true;

    correctBytes = await _load("sounds/correct.mp3");
    wrongBytes = await _load("sounds/wrong.mp3");
    startquizBytes = await _load("sounds/startquiz.mp3");
    finishBytes = await _load("sounds/finish.mp3");
    welcomeBytes = await _load("sounds/welcome.mp3");

    // Optional: Set low latency mode
    _player.setReleaseMode(ReleaseMode.stop);
  }

  // helper
  static Future<Uint8List> _load(String path) async {
    final data = await rootBundle.load("assets/$path");
    return data.buffer.asUint8List();
  }

  // ---------- PLAYERS ----------
  static Future<void> correct() async =>
      _player.play(BytesSource(correctBytes));

  static Future<void> wrong() async => _player.play(BytesSource(wrongBytes));

  static Future<void> startquiz() async =>
      _player.play(BytesSource(startquizBytes));

  static Future<void> finish() async => _player.play(BytesSource(finishBytes));

  static Future<void> welcome() async =>
      _player.play(BytesSource(welcomeBytes));
}
