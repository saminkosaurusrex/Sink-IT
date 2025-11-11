import 'package:flutter/material.dart';
import 'package:sink_it/models/game_config.dart';

class PlayerSetupScreen extends StatelessWidget {
  final GameConfig gameConfig;

  const PlayerSetupScreen({required this.gameConfig, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Player Setup')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Board Size: ${gameConfig.boardSize}x${gameConfig.boardSize}'),
            Text('Sound: ${gameConfig.soundEnabled ? "ON" : "OFF"}'),
            Text('Animations: ${gameConfig.animationsEnabled ? "ON" : "OFF"}'),
          ],
        ),
      ),
    );
  }
}
