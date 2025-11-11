import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sink_it/models/game.dart';
import 'package:sink_it/models/game_config.dart';
import 'package:sink_it/models/Player.dart';
import 'package:sink_it/models/ship/ship.dart';
import 'package:sink_it/services/api_service.dart';

part 'game_provider.g.dart';

// ============= API SERVICE PROVIDER =============
@riverpod
ApiService apiService(Ref ref) {
  return ApiService(baseUrl: 'http://localhost:8000');
}

// ============= GAME STATE PROVIDERS =============
@riverpod
class BoardSize extends _$BoardSize {
  @override
  int build() => 10;

  void setSize(int size) => state = size;
}

@riverpod
class CurrentGame extends _$CurrentGame {
  @override
  Game? build() => null;

  void setGame(Game game) => state = game;
}

@riverpod
class CurrentPlayer extends _$CurrentPlayer {
  @override
  Player? build() => null;

  void setPlayer(Player player) => state = player;
}

@riverpod
class Player1Ships extends _$Player1Ships {
  @override
  List<Ship> build() => [];

  void addShip(Ship ship) => state = [...state, ship];

  void setShips(List<Ship> ships) => state = ships;

  void clearShips() => state = [];
}

@riverpod
class Player2Ships extends _$Player2Ships {
  @override
  List<Ship> build() => [];

  void addShip(Ship ship) => state = [...state, ship];

  void setShips(List<Ship> ships) => state = ships;

  void clearShips() => state = [];
}

// ============= API CALL PROVIDERS =============

/// Create a new game
@riverpod
Future<Game> createGame(Ref ref, {required GameConfig config}) async {
  final api = ref.watch(apiServiceProvider);
  return api.createGame(config);
}

/// Join an existing game
@riverpod
Future<Player> joinGame(
  Ref ref, {
  required String gameId,
  required String playerName,
}) async {
  final api = ref.watch(apiServiceProvider);
  return api.joinGame(gameId, playerName);
}

/// Place ships for a player
@riverpod
Future<void> placeShips(
  Ref ref, {
  required String gameId,
  required String playerId,
  required List<Ship> ships,
}) async {
  final api = ref.watch(apiServiceProvider);
  await api.placeShips(gameId, playerId, ships);
}

/// Set player as ready
@riverpod
Future<void> setPlayerReady(
  Ref ref, {
  required String gameId,
  required String playerId,
}) async {
  final api = ref.watch(apiServiceProvider);
  await api.setPlayerReady(gameId, playerId);
}
