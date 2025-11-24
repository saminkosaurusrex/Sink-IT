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
    print('🎮 ATTACK DEBUG:');
    print('CurrentPlayerIndex: ${game.currentPlayerIndex}');
    print('Player 1 ID: ${game.player1?.id}');
    print('Player 2 ID: ${game.player2?.id}');
    print('CurrentPlayer: ${game.getCurrentPlayer.id}');
    print('Opponent: ${game.getCurrentOpponent.id}');

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

      // ✅ PRIDAJ DEBUG PRED POSLANÍM
      print('🚀 SENDING ATTACK:');
      print('Attacker ID: ${currentPlayer.id}');
      print('Target ID: ${opponent.id}');
      print('Position: ${position.posX}, ${position.posY}');

      final response = await api.attack(
        gameId: game.id,
        attackerId: currentPlayer.id,
        target: opponent.id,
        pos: position,
      );

      // ✅ Updatuj správny board
      if (isPlayer1Attacking) {
        // Player 1 útočí → updatuj playerBoard
        final updatedPlayerBoard = Map<Position, CellState>.from(
          state.playerBoard,
        );

        if (response.hit) {
          updatedPlayerBoard[position] = CellState.hit;
          Ship? hitShip;
          for (var ship in opponent.ships) {
            if (ship.placedPositions.any(
              (p) => p.posX == position.posX && p.posY == position.posY,
            )) {
              hitShip = ship;
              break;
            }
          }

          // ✅ Pridaj hit do lodí
          if (hitShip != null &&
              !hitShip.hits.any(
                (h) => h.posX == position.posX && h.posY == position.posY,
              )) {
            final updatedHits = [...hitShip.hits, position];

            // Aktualizuj loď v zozname lodí
            final shipIndex = opponent.ships.indexOf(hitShip);
            opponent.ships[shipIndex] = hitShip.copyWith(hits: updatedHits);
          }

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
          Ship? hitShip;
          for (var ship in opponent.ships) {
            if (ship.placedPositions.any(
              (p) => p.posX == position.posX && p.posY == position.posY,
            )) {
              hitShip = ship;
              break;
            }
          }

          // ✅ Pridaj hit do lodí
          if (hitShip != null &&
              !hitShip.hits.any(
                (h) => h.posX == position.posX && h.posY == position.posY,
              )) {
            final updatedHits = [...hitShip.hits, position];

            // Aktualizuj loď v zozname lodí
            final shipIndex = opponent.ships.indexOf(hitShip);
            opponent.ships[shipIndex] = hitShip.copyWith(hits: updatedHits);
          }
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

      final allShipsSunk = opponent.ships.every((ship) => ship.isSunk);

      if (allShipsSunk) {
        final gameController = ref.read(gameStateProvider.notifier);
        gameController.setWinner(currentPlayer.id);
        return; // ✅ Ukončí metódu, neprepne ťah
      }

      final gameController = ref.read(gameStateProvider.notifier);
      if (!response.hit) {
        gameController.switchTurn();
      }
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
