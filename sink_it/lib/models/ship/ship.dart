import 'package:sink_it/models/position.dart';
import 'package:sink_it/models/ship/shape_cell.dart';

class Ship {
  final String id;
  final String name;
  // relative positions in ship creation grid
  final List<ShapeCell> shape;
  // absolute position in main game grid
  final List<Position> placedPositions;

  Ship({
    required this.id,
    required this.name,
    required this.shape,
    this.placedPositions = const [],
  });

  int get size => shape.length;

  // Pomocné gettery pre bounding box
  int get width {
    if (shape.isEmpty) return 0;
    return shape.map((c) => c.x).reduce((a, b) => a > b ? a : b) + 1;
  }

  int get height {
    if (shape.isEmpty) return 0;
    return shape.map((c) => c.y).reduce((a, b) => a > b ? a : b) + 1;
  }

  Ship copyWith({
    List<ShapeCell>? shape,
    List<Position>? placedPositions,
    String? name,
  }) {
    return Ship(
      id: id,
      name: name ?? this.name,
      shape: shape ?? this.shape,
      placedPositions: placedPositions ?? this.placedPositions,
    );
  }

  Map<String, dynamic> toJson() => {
    'ship_name': name,
    'positions': placedPositions.map((p) => p.toJson()).toList(),
  };
}
