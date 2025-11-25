//Author: Samuel Kudnrat
//Login: xkundrs00

import 'package:sink_it/enums/cell_state.dart';
import 'package:sink_it/models/Player.dart';
import 'package:sink_it/models/game_play_state.dart';
import 'package:sink_it/models/position.dart';
import 'package:sink_it/models/ship/ship.dart';
import 'package:sink_it/providers/api_service_provider.dart';
import 'package:sink_it/providers/game_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'game_play_provider.g.dart';

@Riverpod(keepAlive: true)
class GamePlay extends _$GamePlay {
  @override
  GamePlayState build() {
    return const GamePlayState();
  }

  void initializeBoards() {
    final game = ref.read(gameStateProvider);
    if (game == null) return;

    state = GamePlayState(playerBoard: {}, opponentBoard: {});
  }

  void reset() {
    state = const GamePlayState();
  }

  Future<void> attack(Position position) async {
    final game = ref.read(gameStateProvider);
    if (game == null) return;

    final isPlayer1Attacking = game.currentPlayerIndex == 0;

    final boardToCheck = isPlayer1Attacking
        ? state.playerBoard
        : state.opponentBoard;

    if (boardToCheck.containsKey(position)) {
      throw Exception("Already attacked this position!");
    }

    state = state.copyWith(isAttacking: true);

    try {
      final api = ref.read(apiServiceProvider);
      final currentPlayer = game.getCurrentPlayer;
      final opponent = game.getCurrentOpponent;

      final response = await api.attack(
        gameId: game.id,
        attackerId: currentPlayer.id,
        target: opponent.id,
        pos: position,
      );

      print('📡 SERVER RESPONSE:');
      print('Hit: ${response.hit}');
      print('Sunk ship: ${response.sunkShip}');
      print('Ships remaining: ${response.shipsRemaining}');

      // Update board based on who's attacking
      if (isPlayer1Attacking) {
        final updatedPlayerBoard = Map<Position, CellState>.from(
          state.playerBoard,
        );
        updatedPlayerBoard[position] = response.hit
            ? CellState.hit
            : CellState.miss;

        state = state.copyWith(
          playerBoard: updatedPlayerBoard,
          lastAttackResult: response.sunkShip != null
              ? 'You sunk ${response.sunkShip}!'
              : (response.hit ? 'Hit!' : 'Miss!'),
          isAttacking: false,
        );
      } else {
        final updatedOpponentBoard = Map<Position, CellState>.from(
          state.opponentBoard,
        );
        updatedOpponentBoard[position] = response.hit
            ? CellState.hit
            : CellState.miss;

        state = state.copyWith(
          opponentBoard: updatedOpponentBoard,
          lastAttackResult: response.sunkShip != null
              ? 'You sunk ${response.sunkShip}!'
              : (response.hit ? 'Hit!' : 'Miss!'),
          isAttacking: false,
        );
      }

      // ✅ Skontroluj víťaza pomocou ships_remaining
      if (response.shipsRemaining == 0) {
        print('🏆 WINNER DETECTED!');
        final gameController = ref.read(gameStateProvider.notifier);
        gameController.setWinner(currentPlayer.id);
        return;
      }

      // ✅ Prepni ťah iba ak MISS
      if (!response.hit) {
        print('❌ MISS - Switching turn');
        final gameController = ref.read(gameStateProvider.notifier);
        gameController.switchTurn();
      } else {
        print('✅ HIT - Same player continues');
      }
    } catch (e) {
      print('❌ ERROR: $e');
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
