import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sink_it/models/game.dart';
import 'package:sink_it/models/game_config.dart';
import 'package:sink_it/models/Player.dart';
import 'package:sink_it/models/ship/ship.dart';

// ============= EXCEPTIONS =============
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}

// ============= API SERVICE =============
class ApiService {
  final String baseUrl;
  late final http.Client _client;

  ApiService({this.baseUrl = 'http://localhost:8000'}) {
    _client = http.Client();
  }

  /// Helper method for making HTTP requests
  Future<dynamic> _request(
    String method,
    String endpoint, {
    dynamic body,
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {'Content-Type': 'application/json'};

    try {
      late final http.Response response;

      switch (method) {
        case 'GET':
          response = await _client.get(url, headers: headers);
          break;
        case 'POST':
          response = await _client.post(
            url,
            headers: headers,
            body: body != null ? jsonEncode(body) : null,
          );
          break;
        case 'DELETE':
          response = await _client.delete(url, headers: headers);
          break;
        default:
          throw ApiException(message: 'Unsupported method: $method');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        if (response.body.isEmpty) return null;
        return jsonDecode(response.body);
      } else {
        try {
          final error = jsonDecode(response.body);
          throw ApiException(
            message: error['detail'] ?? 'Unknown error',
            statusCode: response.statusCode,
          );
        } catch (_) {
          throw ApiException(
            message: 'HTTP Error ${response.statusCode}',
            statusCode: response.statusCode,
          );
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  // ============= GAME ENDPOINTS =============

  /// Create a new game with custom configuration
  Future<Game> createGame(GameConfig config) async {
    final response = await _request(
      'POST',
      '/games',
      body: {'config': config.toJson()},
    );
    return Game.fromJson(response);
  }

  /// List all active games
  Future<List<Game>> listGames() async {
    final response = await _request('GET', '/games');
    return (response as List).map((g) => Game.fromJson(g)).toList();
  }

  /// Get game details
  Future<Game> getGame(String gameId) async {
    final response = await _request('GET', '/games/$gameId');
    return Game.fromJson(response);
  }

  /// Join an existing game
  Future<Player> joinGame(String gameId, String playerName) async {
    final response = await _request(
      'POST',
      '/games/$gameId/join',
      body: {'player_name': playerName},
    );
    return Player.fromJson(response);
  }

  /// Delete a game
  Future<void> deleteGame(String gameId) async {
    await _request('DELETE', '/games/$gameId');
  }

  // ============= SHIP PLACEMENT ENDPOINTS =============

  /// Place multiple ships on the board
  Future<dynamic> placeShips(
    String gameId,
    String playerId,
    List<Ship> ships,
  ) async {
    final shipsJson = ships
        .map(
          (s) => {
            'ship_name': s.name,
            'positions': s.placedPositions.map((p) => p.toJson()).toList(),
          },
        )
        .toList();

    final response = await _request(
      'POST',
      '/games/$gameId/players/$playerId/ships',
      body: {'ships': shipsJson},
    );
    return response;
  }

  // ============= PLAYER ENDPOINTS =============

  /// Mark player as ready to start the game
  Future<dynamic> setPlayerReady(String gameId, String playerId) async {
    final response = await _request(
      'POST',
      '/games/$gameId/players/$playerId/ready',
    );
    return response;
  }

  /// Cleanup resources
  void dispose() {
    _client.close();
  }
}
