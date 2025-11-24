import 'package:sink_it/models/position.dart';

class AttackResponse {
  final bool hit;
  final String? sunkShip;
  final List<Position> affectedPos;

  AttackResponse({required this.hit, this.sunkShip, required this.affectedPos});

  factory AttackResponse.fromJson(Map<String, dynamic> json) {
    return AttackResponse(
      hit: json['hit'],
      sunkShip: json['sunk_ship'],
      affectedPos: (json['affected_positions'] as List)
          .map((pos) => Position(posX: pos['x'], posY: pos['y']))
          .toList(),
    );
  }
}
