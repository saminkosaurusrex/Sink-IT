//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:sink_it/models/position.dart';

// attack response model for api response fro attack
class AttackResponse {
  final bool hit;
  final String? sunkShip;
  final List<Position> affectedPos;
  final int shipsRemaining;

  AttackResponse({
    required this.hit,
    this.sunkShip,
    required this.affectedPos,
    required this.shipsRemaining,
  });

  factory AttackResponse.fromJson(Map<String, dynamic> json) {
    return AttackResponse(
      hit: json['hit'],
      sunkShip: json['sunk_ship'],
      affectedPos: (json['affected_positions'] as List)
          .map((pos) => Position(posX: pos['x'], posY: pos['y']))
          .toList(),
      shipsRemaining: json['ships_remaining'],
    );
  }
}
