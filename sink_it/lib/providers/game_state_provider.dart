//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sink_it/enums/game_status.dart';
import 'package:sink_it/models/player.dart';
import 'package:sink_it/models/game.dart';
import 'package:sink_it/models/game_config.dart';
import 'package:sink_it/models/ship/ship.dart';
import 'package:sink_it/providers/api_service_provider.dart';

part 'game_state_provider.g.dart';

@Riverpod(keepAlive: true)
class GameState extends _$GameState {
  @override
  Game? build() {
    return null;
  }

  /// API: Vytvorenie novej hry (volá server)
  Future<void> createGame(GameConfig config) async {
    try {
      // 1. Volaj server API pre vytvorenie hry
      final api = ref.read(apiServiceProvider);
      final serverGame = await api.createGame(config);

      // 2. Player 1 sa pripojí
      final player1 = await api.joinGame(serverGame.id, 'Player 1');

      // 3. Player 2 sa pripojí
      final player2 = await api.joinGame(serverGame.id, 'Player 2');

      // 4. Ulož hru do lokálneho stavu s reálnymi server IDs
      state = Game(
        id: serverGame.id, // ← Server ID!
        config: config,
        player1: player1, // ← Server player s ID!
        player2: player2, // ← Server player s ID!
        status: GameStatus.setup,
        currentPlayerIndex: 0,
      );
    } catch (e) {
      throw Exception('Failed to create game: $e');
    }
  }

  void sumbitPlayerShips(List<Ship> ships) {
    if (state == null) return;

    final currentPLayer = state!.getCurrentPlayer;

    final updatedPlayer = Player(
      id: currentPLayer.id,
      name: currentPLayer.name,
      ships: ships,
      isReady: true,
    );

    if (state!.currentPlayerIndex == 0) {
      state = Game(
        id: state!.id,
        config: state!.config,
        player1: updatedPlayer,
        player2: state!.player2,
        status: state!.status,
        winnerId: state!.winnerId,
        currentPlayerIndex: 1,
      );
    } else {
      state = Game(
        id: state!.id,
        config: state!.config,
        player1: state!.player1,
        player2: updatedPlayer,
        status: GameStatus.ready,
        winnerId: state!.winnerId,
        currentPlayerIndex: state!.currentPlayerIndex,
      );
    }
  }

  void goToPreviousPlayer() {
    if (state == null || state!.currentPlayerIndex == 0) return;

    state = Game(
      id: state!.id,
      config: state!.config,
      player1: state!.player1,
      player2: state!.player2,
      status: state!.status,
      winnerId: state!.winnerId,
      currentPlayerIndex: state!.currentPlayerIndex - 1,
    );
  }

  void resetGame() {
    state = null;
  }

  void setWinner(String winnerId) {
    if (state == null) return;
    state = Game(
      id: state!.id,
      config: state!.config,
      player1: state!.player1,
      player2: state!.player2,
      status: GameStatus.end,
      winnerId: winnerId,
      currentPlayerIndex: state!.currentPlayerIndex,
    );
  }

  void startGame() {
    if (state == null) return;
    if (!state!.player1!.isReady || !state!.player2!.isReady) return;

    state = Game(
      id: state!.id,
      config: state!.config,
      player1: state!.player1,
      player2: state!.player2,
      status: GameStatus.inProgrress,
      winnerId: state!.winnerId,
      currentPlayerIndex: 0, // Player 1 začíná
    );
  }

  void switchTurn() {
    if (state == null) return;

    final nextIndex = state!.currentPlayerIndex == 0 ? 1 : 0;

    state = Game(
      id: state!.id,
      config: state!.config,
      player1: state!.player1,
      player2: state!.player2,
      status: state!.status,
      winnerId: state!.winnerId,
      currentPlayerIndex: nextIndex,
    );
  }

  void endGame(String winnerId) {
    if (state == null) return;

    state = Game(
      id: state!.id,
      config: state!.config,
      player1: state!.player1,
      player2: state!.player2,
      status: GameStatus.end,
      winnerId: winnerId,
      currentPlayerIndex: state!.currentPlayerIndex,
    );
  }

  void updatePlayerName(String newName) {
    if (state == null) return;

    final currentIndex = state!.currentPlayerIndex;

    if (currentIndex == 0 && state!.player1 != null) {
      state = Game(
        id: state!.id,
        config: state!.config,
        player1: state!.player1!.copyWith(name: newName),
        player2: state!.player2,
        status: state!.status,
        winnerId: state!.winnerId,
        currentPlayerIndex: state!.currentPlayerIndex,
      );
    } else if (currentIndex == 1 && state!.player2 != null) {
      state = Game(
        id: state!.id,
        config: state!.config,
        player1: state!.player1,
        player2: state!.player2!.copyWith(name: newName),
        status: state!.status,
        winnerId: state!.winnerId,
        currentPlayerIndex: state!.currentPlayerIndex,
      );
    }
  }

  Player? getCurrentPlayer() {
    return state?.getCurrentPlayer;
  }

  Player? getOpponent() {
    return state?.getCurrentOpponent;
  }

  bool hasGame() {
    return state != null;
  }
}

// ========== COMPUTED PROVIDERS ==========

@riverpod
Game? currentGame(Ref ref) {
  return ref.watch(gameStateProvider);
}

@riverpod
Player? currentPLayer(Ref ref) {
  final game = ref.watch(gameStateProvider);
  return game?.getCurrentPlayer;
}

@riverpod
Player? currentOpponent(Ref ref) {
  final game = ref.watch(gameStateProvider);
  return game?.getCurrentOpponent;
}

@riverpod
String currentPlayerName(Ref ref) {
  final game = ref.watch(gameStateProvider);
  if (game == null) return "Unknown";
  return game.getCurrentPlayer.name;
}

@riverpod
int currentPlayerIndex(Ref ref) {
  final game = ref.watch(gameStateProvider);
  return game?.currentPlayerIndex ?? 0;
}

@riverpod
bool allPLayersReady(Ref ref) {
  final game = ref.watch(gameStateProvider);
  if (game == null) return false;
  return game.player1!.isReady && game.player2!.isReady;
}

@riverpod
bool isSetupState(Ref ref) {
  final game = ref.watch(gameStateProvider);
  return game?.status == GameStatus.setup;
}

@riverpod
bool isProgressState(Ref ref) {
  final game = ref.watch(gameStateProvider);
  return game?.status == GameStatus.inProgrress;
}

@riverpod
bool isEndState(Ref ref) {
  final game = ref.watch(gameStateProvider);
  return game?.status == GameStatus.end;
}

@riverpod
String? winnerID(Ref ref) {
  final game = ref.watch(gameStateProvider);
  return game?.winnerId;
}

@riverpod
Player? player1(Ref ref) {
  final game = ref.watch(gameStateProvider);
  return game?.player1;
}

@riverpod
Player? player2(Ref ref) {
  final game = ref.watch(gameStateProvider);
  return game?.player2;
}

@riverpod
GameConfig? gameConfigFromGame(Ref ref) {
  final game = ref.watch(gameStateProvider);
  return game?.config;
}

@riverpod
GameStatus? gameStatus(Ref ref) {
  final game = ref.watch(gameStateProvider);
  return game?.status;
}
