//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:sink_it/models/position.dart';
import 'package:sink_it/models/ship/ship.dart';

class ShipPlacementHelper {
  static bool canPlaceShip(
    Ship ship,
    Position startPosition,
    int borderSize,
    List<Ship> placedShips,
  ) {
    //check if ship is inside the board
    for (var cell in ship.shape) {
      final x = startPosition.posX + cell.posX;
      final y = startPosition.posY + cell.posX;

      if (x < 0 || x >= borderSize || y < 0 || y >= borderSize) {
        return false;
      }
    }
    //position on board
    final newPosition = ship.shape.map((cell) {
      return Position(
        posX: startPosition.posX + cell.posX,
        posY: startPosition.posY + cell.posY,
      );
    }).toSet();

    //check if ship isnt over any other ship (ale ignoruj samotnú loď)
    for (var placedShip in placedShips) {
      if (placedShip.id == ship.id) {
        continue;
      }
      final existingPosition = placedShip.placedPositions.toSet();
      // check if there is intersetion in positions of new ship and already palced ship
      if (newPosition.intersection(existingPosition).isNotEmpty) {
        return false;
      }
      // check for no contact(one cell gap between ships)
      for (var newPos in newPosition) {
        for (var existPos in existingPosition) {
          final dx = (newPos.posX - existPos.posX).abs();
          final dy = (newPos.posY - existPos.posY).abs();
          if (dx <= 1 && dy <= 1) {
            return false;
          }
        }
      }
    }

    return true;
  }

  static Ship placeShip(Ship ship, Position startPosition) {
    final positions = ship.shape.map((cell) {
      return Position(
        posX: startPosition.posX + cell.posX,
        posY: startPosition.posY + cell.posY,
      );
    }).toList();
    return ship.copyWith(placedPositions: positions);
  }

  static Map<Position, dynamic> getShipPositions(List<Ship> ships) {
    final Map<Position, dynamic> positions = {};
    for (var ship in ships) {
      for (var position in ship.placedPositions) {
        positions[position] = ship;
      }
    }
    return positions;
  }
}
