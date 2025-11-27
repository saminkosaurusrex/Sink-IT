//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:audioplayers/audioplayers.dart';

class SoundManager {
  final AudioPlayer _player = AudioPlayer();

  Future<void> init() async {
    await _player.setVolume(1.0);
  }

  //hit sound
  Future<void> hit() async {
    await _player.play(AssetSource('sounds/hit.wav'));
  }

  //miss sound
  Future<void> miss() async {
    await _player.play(AssetSource('sounds/miss.wav'));
  }

  Future<void> win() async {
    await _player.play(AssetSource('sounds/win.mp3'));
  }

  void dispose() {
    _player.dispose();
  }
}
