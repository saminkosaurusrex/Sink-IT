//Author: Samuel Kundrart
//login: Xkundrs00

import 'package:sink_it/enums/cell_state.dart';
import 'package:sink_it/models/position.dart';

class GamePlayState {
  final Map<Position, CellState> playerBoard;
  final Map<Position, CellState> opponentBoard;
  final bool isAttacking;
  final String? lastAttackResult;

  const GamePlayState({
    this.playerBoard = const {},
    this.opponentBoard = const {},
    this.isAttacking = false,
    this.lastAttackResult,
  });

  GamePlayState copyWith({
    Map<Position, CellState>? playerBoard,
    Map<Position, CellState>? opponentBoard,
    bool? isAttacking,
    String? lastAttackResult,
  }) {
    return GamePlayState(
      playerBoard: playerBoard ?? this.playerBoard,
      opponentBoard: opponentBoard ?? this.opponentBoard,
      isAttacking: isAttacking ?? this.isAttacking,
      lastAttackResult: lastAttackResult ?? this.lastAttackResult,
    );
  }
}
