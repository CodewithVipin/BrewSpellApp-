import 'package:audioplayers/audioplayers.dart';

class SoundPlayer {
  static final AudioPlayer _player = AudioPlayer();

  static Future<void> playCorrect() async {
    await _player.play(AssetSource("sounds/correct.mp3"));
  }

  static Future<void> playWrong() async {
    await _player.play(AssetSource("sounds/wrong.mp3"));
  }

  static Future<void> playStart() async {
    await _player.play(AssetSource("sounds/startquiz.mp3"));
  }

  static Future<void> playFinish() async {
    await _player.play(AssetSource("sounds/finish.mp3"));
  }

  static Future<void> playWelcome() async {
    await _player.play(AssetSource("sounds/welcome.mp3"));
  }
}
