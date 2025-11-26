//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sink_it/enums/cell_state.dart';
import 'package:sink_it/helpers/ship_placement_helper.dart';
import 'package:sink_it/managers/sound_manager.dart';
import 'package:sink_it/models/position.dart';
import 'package:sink_it/models/ship/ship.dart';
import 'package:sink_it/providers/game_config_provider.dart';
import 'package:sink_it/providers/api_service_provider.dart';
import 'package:sink_it/providers/game_state_provider.dart';

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

  factory ShipPlacementState.initial(List<Ship> fleet) {
    return ShipPlacementState(
      placedShips: const [],
      selectedShip: fleet.isNotEmpty ? fleet[0] : null,
      selectedShipIndex: 0,
      isSubmitting: false,
    );
  }
}

@riverpod
class ShipPlacement extends _$ShipPlacement {
  @override
  ShipPlacementState build() {
    final fleet = ref.watch(gameConfigControllerProvider).fleet;
    return ShipPlacementState.initial(fleet);
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

    //place the ship
    final placedShip = ShipPlacementHelper.placeShip(
      state.selectedShip!,
      position,
    );

    final updatedPlacedShips = List<Ship>.from(state.placedShips);
    //check if it is already placed ship
    final existingIndex = updatedPlacedShips.indexWhere(
      (s) => s.id == state.selectedShip!.id,
    );

    //update placed or add to placed
    if (existingIndex != -1) {
      updatedPlacedShips[existingIndex] = placedShip;
    } else {
      updatedPlacedShips.add(placedShip);
    }

    //find index of next ship to place
    final nextUnplacedIndex = _fleet.indexWhere(
      (s) => !updatedPlacedShips.any((ps) => ps.id == s.id),
    );

    Ship? nextSelectedShip = state.selectedShip;
    int nextIndex = state.selectedShipIndex;

    if (nextUnplacedIndex != -1) {
      nextSelectedShip = _fleet[nextUnplacedIndex];
      nextIndex = nextUnplacedIndex;
    }

    //update state
    state = state.copyWith(
      placedShips: updatedPlacedShips,
      selectedShip: nextSelectedShip,
      selectedShipIndex: nextIndex,
    );

    // make sound of placing the ship
    final game = ref.read(gameStateProvider);
    if (game!.config.soundEnabled) {
      SoundManager().miss();
    }

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
      final api = ref.read(apiServiceProvider);
      final gameObj = ref.read(gameStateProvider);

      if (gameObj == null) {
        throw Exception('No active game');
      }

      final currentPlayer = gameObj.getCurrentPlayer;

      await api.placeShips(gameObj.id, currentPlayer.id, state.placedShips);

      await api.setPlayerReady(gameObj.id, currentPlayer.id);

      final gameController = ref.read(gameStateProvider.notifier);
      gameController.sumbitPlayerShips(state.placedShips);

      //reset fro next player to place ships
      state = ShipPlacementState.initial(_fleet);
    } catch (e) {
      state = state.copyWith(isSubmitting: false);
      rethrow;
    }
  }

  void reset() {
    state = ShipPlacementState.initial(_fleet);
  }

  void _removeShip(String shipId) {
    final updated = List<Ship>.from(state.placedShips)
      ..removeWhere((ship) => ship.id == shipId);

    state = state.copyWith(placedShips: updated);
  }

  void rotateShip() {
    final ship = state.selectedShip;
    if (ship == null) return;

    final isPlaced = state.placedShips.any((s) => s.id == ship.id);

    // ❌ ODSTRÁŇ TOTO:
    // Ship clean = _fleet.firstWhere((s) => s.id == ship.id);

    // ✅ Rotuj AKTUÁLNU loď (ktorá už môže byť rotovaná)
    if (isPlaced) {
      _removeShip(ship.id);
    }

    // ✅ Rotuj shape aktuálnej vybranej lode
    final rotatedShape = _rotateShape(ship.shape);
    final rotatedShip = ship.copyWith(shape: rotatedShape);

    // Zistí index vybranej lode
    final idx = _fleet.indexWhere((s) => s.id == ship.id);

    // Aktualizuj stav
    state = state.copyWith(selectedShip: rotatedShip, selectedShipIndex: idx);
  }

  List<Position> _rotateShape(List<Position> shape) {
    return shape
        .map((cell) => Position(posX: -cell.posY, posY: cell.posX))
        .toList();
  }
}

@riverpod
bool isSubmitting(Ref ref) {
  return ref.watch(shipPlacementProvider).isSubmitting;
}

@riverpod
int placedShipsCount(Ref ref) {
  return ref.watch(shipPlacementProvider).placedShips.length;
}

@riverpod
Ship? selectedShip(Ref ref) {
  return ref.watch(shipPlacementProvider).selectedShip;
}
