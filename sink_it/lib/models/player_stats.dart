//Author: Samuel Kundrat
//Login: xkundrs00

class PlayerStats {
  final int hits;
  final int misses;

  const PlayerStats({this.hits = 0, this.misses = 0});

  //totoal hits getter
  int get total => hits + misses;

  //accuracy getter
  double get accuracy => total > 0 ? (hits / total) * 100 : 0.0;

  //helper for state change
  PlayerStats copyWith({int? hits, int? misses}) {
    return PlayerStats(hits: hits ?? this.hits, misses: misses ?? this.misses);
  }

  //callbacks for increment, decrement
  PlayerStats incrementHits() => copyWith(hits: hits + 1);
  PlayerStats incrementMIsses() => copyWith(misses: misses + 1);
}
