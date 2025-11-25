//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:sink_it/enums/game_status.dart';
import 'package:sink_it/models/player.dart';
import 'package:sink_it/models/game_config.dart';

class Game {
  final String id;
  final GameConfig config;
  final Player? player1;
  final Player? player2;
  final GameStatus status;
  final String? winnerId;
  final int currentPlayerIndex;

  Game({
    required this.id,
    required this.config,
    this.player1,
    this.player2,
    required this.status,
    this.winnerId,
    this.currentPlayerIndex = 0,
  });

  Player get getCurrentPlayer {
    if (currentPlayerIndex == 0 && player1 != null) return player1!;
    if (currentPlayerIndex == 1 && player2 != null) return player2!;
    throw StateError('Current player not available');
  }

  Player get getCurrentOpponent {
    if (currentPlayerIndex == 0 && player2 != null) return player2!;
    if (currentPlayerIndex == 1 && player1 != null) return player1!;
    throw StateError('Opponent not available');
  }

  bool get hasPlayer1 => player1 != null;
  bool get hasPlayer2 => player2 != null;
  bool get hasBothPlayers => player1 != null && player2 != null;

  factory Game.fromJson(Map<String, dynamic> json) {
    final playersList = json['players'] as List<dynamic>;

    return Game(
      id: json['id'],
      config: GameConfig.fromJson(json['config']),
      player1: playersList.isNotEmpty ? Player.fromJson(playersList[0]) : null,
      player2: playersList.length > 1 ? Player.fromJson(playersList[1]) : null,
      status: GameStatus.fromString(json['status']),
      winnerId: json['winner_id'],
      currentPlayerIndex: json['current_player_index'] ?? 0,
    );
  }
}
