//Author: Smaule Kundrat
// login xkundrs00
import 'package:http/http.dart' as http;
import 'package:sink_it/exceptions/api_exception.dart';
import 'package:sink_it/models/Player.dart';
import 'dart:convert';
import 'package:sink_it/models/game.dart';
import 'package:sink_it/models/game_config.dart';
import 'package:sink_it/models/position.dart';
import 'package:sink_it/models/ship/attack_response.dart';
import 'package:sink_it/models/ship/ship.dart';

class ApiService {
  final String baseUrl;
  final http.Client _client;

  ApiService({required this.baseUrl, http.Client? client})
    : _client = client ?? http.Client();

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'appplication/json',
  };

  // api call for game creation
  Future<Game> createGame(GameConfig config) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/games'),
        headers: _headers,
        body: jsonEncode({'config': config.toJson()}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Game.fromJson(data);
      } else {
        throw ApiException(
          'Failed to create a game: ${response.body}',
          response.body,
        );
      }
    } catch (e) {
      throw ApiException('Network error creating a game', e.toString());
    }
  }

  //api call for get a game
  Future<Game> getGame(String id) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/games/$id'),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Game.fromJson(data);
      } else {
        throw ApiException(
          'Failed to get game: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      throw ApiException('Network error getting game', e.toString());
    }
  }

  //--- PLAYER ---

  //joining
  Future<Player> joinGame(String id, String name) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/games/$id/join'),
        headers: _headers,
        body: jsonEncode({'player_name': name}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Player.fromJson(data);
      } else {
        throw ApiException(
          'Failed to join the game: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      throw ApiException('Network error joining game', e.toString());
    }
  }

  //placing shiups
  Future<void> placeShips(
    String gameID,
    String playerId,
    List<Ship> ships,
  ) async {
    try {
      final shipsJson = ships.map((ship) {
        final json = ship.toJson();
        print('🔍 Ship JSON: $json'); // ← DEBUG
        return json;
      }).toList();

      print('📦 All ships JSON: $shipsJson');
      final response = await _client.post(
        Uri.parse('$baseUrl/games/$gameID/players/$playerId/ships'),
        headers: _headers,
        body: jsonEncode({'ships': shipsJson}),
      );
      if (response.statusCode != 200) {
        throw ApiException(
          'Failed to place ships for player: $playerId, code: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      throw ApiException('Network error placing ships', e.toString());
    }
  }

  //setting player ready
  Future<void> setPlayerReady(String gameID, String playerID) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/games/$gameID/players/$playerID/ready'),
        headers: _headers,
      );

      if (response.statusCode != 200) {
        throw ApiException(
          'Failed to set Player: $playerID ready! code: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      throw ApiException(
        'Network error setting player: $playerID ready',
        e.toString(),
      );
    }
  }

  // --- Game --
  Future<AttackResponse> attack({
    required String gameId,
    required String attackerId,
    required String target,
    required Position pos,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/gmaes/$gameId/attack'),
        headers: _headers,
        body: ({
          'attacker_id': attackerId,
          'target_id': target,
          'position': pos.toJson(),
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AttackResponse.fromJson(data);
      } else {
        throw ApiException(
          'Failed to attack Player: $target, code: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      throw ApiException('Network fail during attack', e.toString());
    }
  }

  // delete game

  Future<void> deleteGame(String gameId) async {
    try {
      final response = await _client.delete(
        Uri.parse('$baseUrl/games/$gameId'),
        headers: _headers,
      );

      if (response.statusCode != 200) {
        throw ApiException(
          'Failed to delete the game: $gameId, code:${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      throw ApiException(
        'Network error during deletion of the game!',
        e.toString(),
      );
    }
  }

  void dispose() {
    _client.close();
  }
}
