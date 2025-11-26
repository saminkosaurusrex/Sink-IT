class PlayerStats {
  final int hits;
  final int misses;

  const PlayerStats({this.hits = 0, this.misses = 0});

  int get total => hits + misses;

  double get accuracy => total > 0 ? (hits / total) * 100 : 0.0;

  PlayerStats copyWith({int? hits, int? misses}) {
    return PlayerStats(hits: hits ?? this.hits, misses: misses ?? this.misses);
  }

  PlayerStats incrementHits() => copyWith(hits: hits + 1);
  PlayerStats incrementMIsses() => copyWith(misses: misses + 1);
}
