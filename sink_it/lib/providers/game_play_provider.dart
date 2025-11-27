//Author: Samuel Kudnrat
//Login: xkundrs00

import 'package:sink_it/enums/cell_state.dart';
import 'package:sink_it/managers/sound_manager.dart';
import 'package:sink_it/models/game_play_state.dart';
import 'package:sink_it/models/position.dart';
import 'package:sink_it/providers/api_service_provider.dart';
import 'package:sink_it/providers/game_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'game_play_provider.g.dart';

//game play provider, provides current state of game
@Riverpod(keepAlive: true)
class GamePlay extends _$GamePlay {
  @override
  GamePlayState build() {
    return const GamePlayState();
  }

  //boards initilaizator
  void initializeBoards() {
    final game = ref.read(gameStateProvider);
    if (game == null) return;

    state = GamePlayState();
  }

  //reset to default
  void reset() {
    state = const GamePlayState();
  }

  //atttack enemy methodes
  Future<void> attack(Position position) async {
    //get current state of game
    final game = ref.read(gameStateProvider);
    if (game == null) return;

    final isPlayer1Attacking = game.currentPlayerIndex == 0;

    final boardToCheck = isPlayer1Attacking
        ? state.playerBoard
        : state.opponentBoard;

    if (boardToCheck.containsKey(position)) {
      return;
      //throw Exception("Already attacked this position!");
    }
    //set game to attacking state
    state = state.copyWith(isAttacking: true);

    try {
      final api = ref.read(apiServiceProvider);
      final currentPlayer = game.getCurrentPlayer;
      final opponent = game.getCurrentOpponent;

      //send request to server
      final response = await api.attack(
        gameId: game.id,
        attackerId: currentPlayer.id,
        target: opponent.id,
        pos: position,
      );

      //sound effects
      if (game.config.soundEnabled) {
        if (response.hit) {
          SoundManager().hit();
        } else {
          SoundManager().miss();
        }
      }
      //updated stats player1
      final newPlayer1Stats = isPlayer1Attacking
          ? (response.hit
                ? state.player1Stats.incrementHits()
                : state.player1Stats.incrementMIsses())
          : state.player1Stats;

      //updated stats player2
      final newPlayer2Stats = !isPlayer1Attacking
          ? (response.hit
                ? state.player2Stats.incrementHits()
                : state.player2Stats.incrementMIsses())
          : state.player2Stats;
      // Update board based on who's attacking
      //player1
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
          player1Stats: newPlayer1Stats,
          player2Stats: newPlayer2Stats,
          total: state.total + 1,
        );
      }
      //player2
      else {
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
          player1Stats: newPlayer1Stats,
          player2Stats: newPlayer2Stats,
          total: state.total + 1,
        );
      }
      //win
      if (response.shipsRemaining == 0) {
        final gameController = ref.read(gameStateProvider.notifier);
        gameController.setWinner(currentPlayer.id);
        SoundManager().win();
        return;
      }
      //hotSeat
      if (!response.hit) {
        final gameController = ref.read(gameStateProvider.notifier);
        gameController.switchTurn();
      }
    } catch (e) {
      state = state.copyWith(isAttacking: false);
      throw Exception("Attack failed: $e");
    }
  }
}

//state of last result
@riverpod
String? lastAttackResult(Ref ref) {
  return ref.watch(gamePlayProvider).lastAttackResult;
}

//state of isattacking
@riverpod
bool isAttacking(Ref ref) {
  return ref.watch(gamePlayProvider).isAttacking;
}

//state of remaining enemy ships
@riverpod
int remainingEnemyShips(Ref ref) {
  final game = ref.watch(gameStateProvider);
  if (game == null) return 0;
  final opponent = game.getCurrentOpponent;
  return opponent.ships.where((s) => !s.isSunk).length;
}
