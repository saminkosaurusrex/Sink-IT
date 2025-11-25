//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:sink_it/helpers/ship_helper.dart';
import 'package:sink_it/models/game_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sink_it/models/position.dart';
import 'package:sink_it/models/ship/ship.dart';
part 'game_config_provider.g.dart';

@riverpod
class GameConfigController extends _$GameConfigController {
  @override
  GameConfig build() {
    return GameConfig(
      boardSize: 8,
      soundEnabled: true,
      animationsEnabled: true,
    );
  }

  void setBoardSize(int size) {
    if (size != 10 && size != 8) {
      throw ArgumentError('Board size must be 8 or 10');
    }

    state = GameConfig(
      boardSize: size,
      soundEnabled: state.soundEnabled,
      animationsEnabled: state.animationsEnabled,
    );
  }

  void setSoundEnabled(bool soundEnabled) {
    state = state.copyWith(soundEnabled: soundEnabled);
  }

  void setAnimationsEnabled(bool animationsEnabled) {
    state = state.copyWith(animationsEnabled: animationsEnabled);
  }

  void resetToDefaults() {
    state = GameConfig(
      boardSize: 8,
      soundEnabled: true,
      animationsEnabled: true,
    );
  }

  void addShip(List<Position> cells, {String? name}) {
    try {
      final newShip = ShipShapeHelper.normalizeAndValidate(cells);
      final ship = Ship(
        id: newShip.id,
        name: name ?? newShip.name,
        shape: newShip.shape,
      );
      state = state.copyWith(fleet: [...state.fleet, ship]);
    } catch (e) {
      throw Exception('Can\'t add the ship: ${e.toString()}');
    }
  }

  void removeShip(String shipId) {
    state = state.copyWith(
      fleet: state.fleet.where((ship) => ship.id != shipId).toList(),
    );
  }

  GameConfig getConfig() => state;
}

//state of boardSize
@riverpod
int boardSize(Ref ref) {
  return ref.watch(gameConfigControllerProvider).boardSize;
}

//state of sounds setting
@riverpod
bool soundEnabled(Ref ref) {
  return ref.watch(gameConfigControllerProvider).soundEnabled;
}

//state of animations setting
@riverpod
bool animationsEnabled(Ref ref) {
  return ref.watch(gameConfigControllerProvider).animationsEnabled;
}

@riverpod
List<Map<String, dynamic>> fleetInfo(Ref ref) {
  final config = ref.watch(gameConfigControllerProvider);
  return config.fleet
      .map((ship) => {'name': ship.name, 'size': ship.size})
      .toList();
}
