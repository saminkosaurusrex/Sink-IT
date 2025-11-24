enum GameStatus {
  ready,
  setup,
  end,
  inProgrress;

  static GameStatus fromString(String? status) {
    if (status == null) return GameStatus.setup;
    return switch (status) {
      'setup' => GameStatus.setup,
      'ready' => GameStatus.ready,
      'in_progress' => GameStatus.inProgrress,
      'finished' => GameStatus.end,
      _ => GameStatus.setup,
    };
  }
}
