class GameConfig {
  final int boardSize;
  final bool soundEnabled;
  final bool animationsEnabled;

  GameConfig({
    required this.boardSize,
    this.soundEnabled = true,
    this.animationsEnabled = true,
  });

  Map<String, dynamic> toJson() => {
    'board_size': boardSize,
    'sound_enabled': soundEnabled,
    'animations_enabled': animationsEnabled,
    'max_players': 2,
    'allow_customs_ships': true,
    'initial_spells': [],
  };
}
