//Author: Samuel Kudnrat
//Login: xkundrs00

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sink_it/models/ship/shape_cell.dart';
import 'package:sink_it/models/ship/ship.dart';

part 'ship_editor_provider.g.dart';

// boat edditor
@riverpod
class ShipEditor extends _$ShipEditor {
  @override
  Ship? build() {
    return null;
  }

  void startNewShip() {
    state = Ship(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: 'New Boat',
      shape: [],
    );
  }

  void startEditShip(Ship ship) {
    state = ship.copyWith();
  }

  void toggleCell(int x, int y) {
    if (state == null) return;

    final cell = ShapeCell(x: x, y: y);
    final exists = state!.shape.any((c) => c.x == x && c.y == y);

    final newShape = exists
        ? state!.shape.where((c) => !(c.x == x && c.y == y)).toList()
        : [...state!.shape, cell];

    state = state!.copyWith(shape: newShape);
  }

  void setName(String name) {
    if (state == null) return;
    state = state!.copyWith(name: name);
  }

  void clearShape() {
    if (state == null) return;
    state = state!.copyWith(shape: []);
  }

  Ship? getCurrentShip() {
    return state;
  }

  void cancel() {
    state = null;
  }

  bool isCellSelected(int x, int y) {
    if (state == null) return false;
    return state!.shape.any((cell) => cell.x == x && cell.y == y);
  }
}
