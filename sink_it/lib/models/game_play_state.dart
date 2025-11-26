//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:sink_it/enums/cell_state.dart';
import 'package:sink_it/models/player_stats.dart';
import 'package:sink_it/models/position.dart';

class GamePlayState {
  final Map<Position, CellState> playerBoard;
  final Map<Position, CellState> opponentBoard;
  final bool isAttacking;
  final String? lastAttackResult;

  final PlayerStats player1Stats;
  final PlayerStats player2Stats;
  final int total;

  const GamePlayState({
    this.playerBoard = const {},
    this.opponentBoard = const {},
    this.isAttacking = false,
    this.lastAttackResult,
    this.player1Stats = const PlayerStats(),
    this.player2Stats = const PlayerStats(),
    this.total = 0,
  });

  GamePlayState copyWith({
    Map<Position, CellState>? playerBoard,
    Map<Position, CellState>? opponentBoard,
    bool? isAttacking,
    String? lastAttackResult,
    PlayerStats? player1Stats,
    PlayerStats? player2Stats,
    int? total,
  }) {
    return GamePlayState(
      playerBoard: playerBoard ?? this.playerBoard,
      opponentBoard: opponentBoard ?? this.opponentBoard,
      isAttacking: isAttacking ?? this.isAttacking,
      lastAttackResult: lastAttackResult ?? this.lastAttackResult,
      player1Stats: player1Stats ?? this.player1Stats,
      player2Stats: player2Stats ?? this.player2Stats,
      total: total ?? this.total,
    );
  }
}
