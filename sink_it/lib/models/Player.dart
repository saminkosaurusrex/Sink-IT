import 'package:sink_it/models/ship.dart';

class Player {
  final String id;
  final String name;
  final List<Ship> ships;
  final bool isReady;

  Player({
    required this.id,
    required this.name,
    this.ships = const [],
    this.isReady = false,
  });

  factory Player.fromJson(Map<String, dynamic> json) =>
      Player(id: json['id'], name: json['name'], isReady: json['isReady']);
}
