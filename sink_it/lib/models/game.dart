import 'package:sink_it/enums/game_status.dart';
import 'package:sink_it/models/Player.dart';
import 'package:sink_it/models/game_config.dart';

class Game {
  final String id;
  final GameConfig config;
  final Player? player1; // ← NULLABLE!
  final Player? player2; // ← NULLABLE!
  final GameStatus status;
  final String? winnerId;
  final int currentPlayerIndex;

  Game({
    required this.id,
    required this.config,
    this.player1, // ← Voliteľný parameter
    this.player2, // ← Voliteľný parameter
    required this.status,
    this.winnerId,
    this.currentPlayerIndex = 0,
  });

  // Bezpečné gettery s kontrolou
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

  // Pomocné checkery
  bool get hasPlayer1 => player1 != null;
  bool get hasPlayer2 => player2 != null;
  bool get hasBothPlayers => player1 != null && player2 != null;

  /// Normálny fromJson (očakáva hráčov v response)
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

  /// Jednoduchý fromJsonCreate - players sú null
  factory Game.fromJsonCreate(Map<String, dynamic> json) => Game(
    id: json['id'],
    config: GameConfig.fromJson(json['config']),
    player1: null, // ← Žiadni dummy hráči!
    player2: null, // ← Žiadni dummy hráči!
    status: GameStatus.fromString(json['status']),
    winnerId: json['winner_id'],
    currentPlayerIndex: json['current_player_index'] ?? 0,
  );

  /// Helper metóda pre pridanie hráčov
  Game withPlayers({Player? player1, Player? player2}) {
    return Game(
      id: id,
      config: config,
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      status: status,
      winnerId: winnerId,
      currentPlayerIndex: currentPlayerIndex,
    );
  }
}
