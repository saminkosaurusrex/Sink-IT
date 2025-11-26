//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sink_it/models/position.dart';
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

    final cell = Position(posX: x, posY: y);
    final exists = state!.shape.any((c) => c.posX == x && c.posY == y);

    final newShape = exists
        ? state!.shape.where((c) => !(c.posX == x && c.posY == y)).toList()
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
    return state!.shape.any((cell) => cell.posX == x && cell.posY == y);
  }
}
