//Author: Samuel Kudnrat
//Login: xkundrs00

import 'package:sink_it/enums/cell_state.dart';
import 'package:sink_it/models/Player.dart';
import 'package:sink_it/models/game_play_state.dart';
import 'package:sink_it/models/position.dart';
import 'package:sink_it/providers/api_service_provider.dart';
import 'package:sink_it/providers/game_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_play_provider.g.dart';

@Riverpod(keepAlive: true)
class GamePlay extends _$GamePlay {
  @override
  GamePlayState build() {
    final game = ref.watch(gameStateProvider);
    if (game == null) return const GamePlayState();
    return GamePlayState(
      playerBoard: _buildOpponentBoardStates(game.getCurrentPlayer),
      opponentBoard: {},
    );
  }

  Map<Position, CellState> _buildPlayerBoardState(Player player) {
    final Map<Position, CellState> result = {};

    for (var ship in player.ships) {
      for (var position in ship.placedPositions) {
        final isHit = ship.hits.any(
          (h) => h.posX == position.posX && h.posY == position.posY,
        );
        result[position] = isHit ? CellState.hit : CellState.ship;
      }
    }
    return result;
  }

  Map<Position, CellState> _buildOpponentBoardStates(Player opponent) {
    final Map<Position, CellState> result = {};

    for (var ship in opponent.ships) {
      for (var pos in ship.placedPositions) {
        final isHit = ship.hits.any(
          (h) => h.posX == pos.posX && h.posY == pos.posY,
        );
        result[pos] = isHit ? CellState.hit : CellState.ship;
      }
    }
    return result;
  }

  void reset() {
    state = const GamePlayState();
  }

  void refreshBoards() {
    final game = ref.read(gameStateProvider);
    if (game == null) return;
    state = GamePlayState(
      playerBoard: _buildPlayerBoardState(game.getCurrentPlayer),
      opponentBoard: state.opponentBoard,
    );
  }

  Future<void> attack(Position position) async {
    final game = ref.read(gameStateProvider);
    if (game == null) return;

    if (state.opponentBoard.containsKey(position)) {
      throw Exception("Already attacked this position!");
    }

    state = state.copyWith(isAttacking: true);
    try {
      final api = ref.read(apiServiceProvider);
      final currentPlayer = game.getCurrentOpponent;
      final opponent = game.getCurrentOpponent;

      final response = await api.attack(
        gameId: game.id,
        attackerId: currentPlayer.id,
        target: opponent.id,
        pos: position,
      );

      final updatedOpponentStates = Map<Position, CellState>.from(
        state.opponentBoard,
      );

      if (response.hit) {
        updatedOpponentStates[position] = CellState.hit;
        state = state.copyWith(
          opponentBoard: updatedOpponentStates,
          lastAttackResult: response.sunkShip != null
              ? 'You sunk ${response.sunkShip}!'
              : 'Hit!',
          isAttacking: false,
        );
      } else {
        updatedOpponentStates[position] = CellState.miss;
        state = state.copyWith(
          opponentBoard: updatedOpponentStates,
          lastAttackResult: 'Miss!',
          isAttacking: false,
        );
      }

      final gameController = ref.read(gameStateProvider.notifier);
      gameController.switchTurn();
    } catch (e) {
      state = state.copyWith(isAttacking: false);
      throw Exception("Attack failed: $e");
    }
  }
}

@riverpod
String? lastAttackResult(Ref ref) {
  return ref.watch(gamePlayProvider).lastAttackResult;
}

@riverpod
bool isAttacking(Ref ref) {
  return ref.watch(gamePlayProvider).isAttacking;
}

@riverpod
int remainingEnemyShips(Ref ref) {
  final game = ref.watch(gameStateProvider);
  if (game == null) return 0;
  final opponent = game.getCurrentOpponent;
  return opponent.ships.where((s) => !s.isSunk).length;
}

@riverpod
int totalEnemyShips(Ref ref) {
  final game = ref.watch(gameStateProvider);
  if (game == null) return 0;
  return game.getCurrentOpponent.ships.length;
}
