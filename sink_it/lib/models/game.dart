import 'package:sink_it/models/Player.dart';
import 'package:sink_it/models/game_config.dart';

class Game {
  final String id;
  final GameConfig config;
  final Player player1;
  final Player player2;
  final String status;
  final String? winnerId;
  final int currentPlayerIndex;

  Game({
    required this.id,
    required this.config,
    required this.player1,
    required this.player2,
    required this.status,
    this.winnerId,
    this.currentPlayerIndex = 0,
  });

  Player get getCurrentPlayer => currentPlayerIndex == 0 ? player1 : player2;
  Player get getCurrentOpponent => currentPlayerIndex == 0 ? player2 : player1;

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    id: json['id'],
    config: GameConfig(boardSize: json['config']['board_size']),
    player1: Player.fromJson(json['players'][0]),
    player2: Player.fromJson(json['players'][0]),
    status: json['status'],
    winnerId: json['winner_id'],
    currentPlayerIndex: json['current_player_index'],
  );
}
