//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sink_it/models/ship/shape_cell.dart';
import 'package:sink_it/models/ship/ship.dart';

part 'ship_editor_provider.g.dart';

/// Controller pre editáciu JEDNEJ lode
/// Drží dočasný stav počas editácie v gride
@riverpod
class ShipEditor extends _$ShipEditor {
  @override
  Ship? build() {
    return null; // Žiadna loď nie je editovaná
  }

  /// Začne editáciu novej lode
  void startNewShip() {
    state = Ship(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: 'New Boat',
      shape: [], // Prázdny tvar
    );
  }

  /// Začne editáciu existujúcej lode
  void startEditShip(Ship ship) {
    state = ship.copyWith(); // Kópia pre bezpečnú editáciu
  }

  /// Toggle bunky v gride (pridať/odobrať)
  void toggleCell(int x, int y) {
    if (state == null) return;

    final cell = ShapeCell(x: x, y: y);
    final exists = state!.shape.any((c) => c.x == x && c.y == y);

    final newShape = exists
        ? state!.shape.where((c) => !(c.x == x && c.y == y)).toList()
        : [...state!.shape, cell];

    state = state!.copyWith(shape: newShape);
  }

  /// Zmena názvu lode
  void setName(String name) {
    if (state == null) return;
    state = state!.copyWith(name: name);
  }

  /// Vyčistenie celého gridu
  void clearShape() {
    if (state == null) return;
    state = state!.copyWith(shape: []);
  }

  /// Získanie aktuálnej editovanej lode
  Ship? getCurrentShip() {
    return state;
  }

  /// Ukončenie editácie (vyčistenie stavu)
  void cancel() {
    state = null;
  }

  /// Kontrola, či je bunka vybraná
  bool isCellSelected(int x, int y) {
    if (state == null) return false;
    return state!.shape.any((cell) => cell.x == x && cell.y == y);
  }
}
