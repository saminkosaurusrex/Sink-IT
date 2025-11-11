import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sink_it/models/game.dart';
import 'package:sink_it/models/ship.dart';

part 'game_provider.g.dart';

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
class Player1Ships extends _$Player1Ships {
  @override
  List<Ship> build() => [];

  void addShip(Ship ship) => state = [...state, ship];
}

@riverpod
class Player2Ships extends _$Player2Ships {
  @override
  List<Ship> build() => [];

  void addShip(Ship ship) => state = [...state, ship];
}
