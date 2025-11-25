//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:sink_it/models/position.dart';
import 'package:sink_it/models/ship/shape_cell.dart';

class Ship {
  final String id;
  final String name;
  // relative positions in ship creation grid
  final List<ShapeCell> shape;
  // absolute position in main game grid
  final List<Position> placedPositions;
  final List<Position> hits;

  Ship({
    required this.id,
    required this.name,
    required this.shape,
    this.placedPositions = const [],
    this.hits = const [],
  });

  int get size => shape.length;

  bool get isSunk => hits.length == placedPositions.length;

  Ship copyWith({
    List<ShapeCell>? shape,
    List<Position>? placedPositions,
    List<Position>? hits,
    String? name,
  }) {
    return Ship(
      id: id,
      name: name ?? this.name,
      shape: shape ?? this.shape,
      placedPositions: placedPositions ?? this.placedPositions,
      hits: hits ?? this.hits,
    );
  }

  Map<String, dynamic> toJson() => {
    'ship_name': name,
    'positions': placedPositions.map((p) => p.toJson()).toList(),
  };
}
