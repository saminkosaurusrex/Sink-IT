import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sink_it/enums/cell_state.dart';
import 'package:sink_it/helpers/ship_placement_helper.dart';
import 'package:sink_it/models/position.dart';
import 'package:sink_it/models/ship/ship.dart';
import 'package:sink_it/providers/game_config_provider.dart';

part 'ship_placement_provider.g.dart';

class ShipPlacementState {
  final List<Ship> placedShips;
  final Ship? selectedShip;
  final int selectedShipIndex;
  final bool isSubmitting;

  const ShipPlacementState({
    this.placedShips = const [],
    this.selectedShip,
    this.selectedShipIndex = 0,
    this.isSubmitting = false,
  });

  ShipPlacementState copyWith({
    List<Ship>? placedShips,
    Ship? selectedShip,
    int? selectedShipIndex,
    bool? isSubmitting,
  }) {
    return ShipPlacementState(
      placedShips: placedShips ?? this.placedShips,
      selectedShip: selectedShip ?? this.selectedShip,
      selectedShipIndex: selectedShipIndex ?? this.selectedShipIndex,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

@riverpod
class ShipPlacement extends _$ShipPlacement {
  @override
  ShipPlacementState build() {
    final config = ref.watch(gameConfigControllerProvider);

    return ShipPlacementState(
      selectedShip: config.fleet.isNotEmpty ? config.fleet[0] : null,
    );
  }

  int get _boardsize => ref.read(gameConfigControllerProvider).boardSize;
  List<Ship> get _fleet => ref.read(gameConfigControllerProvider).fleet;

  void selectShip(Ship ship) {
    final index = _fleet.indexWhere((s) => s.id == ship.id);
    state = state.copyWith(selectedShip: ship, selectedShipIndex: index);
  }

  bool placeShipAt(Position position) {
    if (state.selectedShip == null) return false;

    if (!ShipPlacementHelper.canPlaceShip(
      state.selectedShip!,
      position,
      _boardsize,
      state.placedShips,
    )) {
      return false;
    }

    final placedShip = ShipPlacementHelper.placeShip(
      state.selectedShip!,
      position,
    );

    final updatedPlacedShips = List<Ship>.from(state.placedShips);
    final existingIndex = updatedPlacedShips.indexWhere(
      (s) => s.id == state.selectedShip!.id,
    );

    //update or add
    if (existingIndex != -1) {
      updatedPlacedShips[existingIndex] = placedShip;
    } else {
      updatedPlacedShips.add(placedShip);
    }

    final nextUnplacedIndex = _fleet.indexWhere(
      (s) => !updatedPlacedShips.any((ps) => ps.id == s.id),
    );

    Ship? nextSelectedShip = state.selectedShip;
    int nextIndex = state.selectedShipIndex;

    if (nextUnplacedIndex != -1) {
      nextSelectedShip = _fleet[nextUnplacedIndex];
      nextIndex = nextUnplacedIndex;
    }

    //move to another ship
    state = state.copyWith(
      placedShips: updatedPlacedShips,
      selectedShip: nextSelectedShip,
      selectedShipIndex: nextIndex,
    );

    return true;
  }

  bool isShipPlaced(String shipId) {
    return state.placedShips.any((s) => s.id == shipId);
  }

  Map<Position, CellState> getCellStates() {
    final Map<Position, CellState> states = {};
    for (var ship in state.placedShips) {
      for (var pos in ship.placedPositions) {
        states[pos] = CellState.ship;
      }
    }
    return states;
  }

  bool canSubmit() {
    return state.placedShips.length == _fleet.length && !state.isSubmitting;
  }

  Future<void> submitShips() async {
    if (!canSubmit()) {
      throw Exception('Cannot submit ships yet');
    }

    state = state.copyWith(isSubmitting: true);

    try {
      // TODO: API call na server
      // final api = ref.read(apiServiceProvider);
      // await api.placeShips(gameId, playerId, state.placedShips);

      // Placeholder pro simulaci API volání
      await Future.delayed(Duration(seconds: 1));

      // Po úspěšném odeslání můžeš resetovat stav nebo navigovat
      state = state.copyWith(isSubmitting: false);
    } catch (e) {
      state = state.copyWith(isSubmitting: false);
      rethrow;
    }
  }

  void reset() {
    final firstShip = _fleet.isNotEmpty ? _fleet[0] : null;
    state = ShipPlacementState(selectedShip: firstShip);
  }

  void removeShip(String shipId) {
    final updatedPlacedShips = state.placedShips
        .where((s) => s.id != shipId)
        .toList();

    state = state.copyWith(placedShips: updatedPlacedShips);
  }
}

@riverpod
bool isSubmitting(Ref ref) {
  return ref.watch(shipPlacementProvider).isSubmitting;
}

/// Počet umístěných lodí
@riverpod
int placedShipsCount(Ref ref) {
  return ref.watch(shipPlacementProvider).placedShips.length;
}

/// Aktuálně vybraná loď
@riverpod
Ship? selectedShip(Ref ref) {
  return ref.watch(shipPlacementProvider).selectedShip;
}
