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
    // ❌ ODSTRÁŇ ref.watch - nechceš automatický rebuild!
    // final game = ref.watch(gameStateProvider);

    // ✅ Vráť prázdny state
    return const GamePlayState();
  }

  void initializeBoards() {
    final game = ref.read(gameStateProvider);
    if (game == null) return;

    state = GamePlayState(playerBoard: {}, opponentBoard: {});
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

    // ✅ Zisti, ktorý hráč útočí
    final isPlayer1Attacking = game.currentPlayerIndex == 0;

    // ✅ Skontroluj správny board
    final boardToCheck = isPlayer1Attacking
        ? state
              .playerBoard // P1 útočí → playerBoard
        : state.opponentBoard; // P2 útočí → opponentBoard

    if (boardToCheck.containsKey(position)) {
      throw Exception("Already attacked this position!");
    }

    print('🎯 BEFORE ATTACK:');
    print('Position: $position');
    print('IsPlayer1Attacking: $isPlayer1Attacking');
    print('PlayerBoard size: ${state.playerBoard.length}');
    print('OpponentBoard size: ${state.opponentBoard.length}');

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

      // ✅ Updatuj správny board
      if (isPlayer1Attacking) {
        // Player 1 útočí → updatuj playerBoard
        final updatedPlayerBoard = Map<Position, CellState>.from(
          state.playerBoard,
        );

        if (response.hit) {
          updatedPlayerBoard[position] = CellState.hit;
          state = state.copyWith(
            playerBoard: updatedPlayerBoard, // ✅ Updatuj P1 board
            lastAttackResult: response.sunkShip != null
                ? 'You sunk ${response.sunkShip}!'
                : 'Hit!',
            isAttacking: false,
          );
        } else {
          updatedPlayerBoard[position] = CellState.miss;
          state = state.copyWith(
            playerBoard: updatedPlayerBoard, // ✅ Updatuj P1 board
            lastAttackResult: 'Miss!',
            isAttacking: false,
          );
        }
      } else {
        // Player 2 útočí → updatuj opponentBoard
        final updatedOpponentBoard = Map<Position, CellState>.from(
          state.opponentBoard,
        );

        if (response.hit) {
          updatedOpponentBoard[position] = CellState.hit;
          state = state.copyWith(
            opponentBoard: updatedOpponentBoard, // ✅ Updatuj P2 board
            lastAttackResult: response.sunkShip != null
                ? 'You sunk ${response.sunkShip}!'
                : 'Hit!',
            isAttacking: false,
          );
        } else {
          updatedOpponentBoard[position] = CellState.miss;
          state = state.copyWith(
            opponentBoard: updatedOpponentBoard, // ✅ Updatuj P2 board
            lastAttackResult: 'Miss!',
            isAttacking: false,
          );
        }
      }

      print('🔄 AFTER STATE UPDATE:');
      print('PlayerBoard size: ${state.playerBoard.length}');
      print('OpponentBoard size: ${state.opponentBoard.length}');

      final gameController = ref.read(gameStateProvider.notifier);
      gameController.switchTurn();

      print('🔄 AFTER SWITCH TURN:');
      print('PlayerBoard size: ${state.playerBoard.length}');
      print('OpponentBoard size: ${state.opponentBoard.length}');
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
