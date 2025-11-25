//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:sink_it/models/ship/ship.dart';

class GameConfig {
  final int boardSize;
  final bool soundEnabled;
  final bool animationsEnabled;
  final List<Ship> fleet;

  int get maxFleetSize {
    if (boardSize == 8) return 3;
    if (boardSize == 10) return 5;
    return 5;
  }

  GameConfig({
    required this.boardSize,
    this.soundEnabled = true,
    this.animationsEnabled = true,
    List<Ship>? fleet,
  }) : fleet = fleet ?? [];

  factory GameConfig.fromJson(Map<String, dynamic> json) {
    return GameConfig(
      boardSize: json['board_size'] ?? 10,
      soundEnabled: json['sound_enabled'] ?? true,
      animationsEnabled: json['animations_enabled'] ?? true,
      fleet: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'board_size': boardSize,
      'max_players': 2,
      'allow_custom_ships': true,
      'initial_spells': [],
    };
  }

  GameConfig copyWith({
    int? boardSize,
    bool? soundEnabled,
    bool? animationsEnabled,
    List<Ship>? fleet,
  }) {
    return GameConfig(
      boardSize: boardSize ?? this.boardSize,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      animationsEnabled: animationsEnabled ?? this.animationsEnabled,
      fleet: fleet ?? this.fleet,
    );
  }
}
