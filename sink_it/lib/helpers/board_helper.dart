import 'package:sink_it/models/position.dart';
import 'package:sink_it/models/ship/ship.dart';

class BoardHelper {
  static List<Position> calculateShipPositions(
    Ship ship,
    Position startPosition,
  ) {
    return ship.shape.map((cell) {
      return Position(
        posX: startPosition.posX + cell.x,
        posY: startPosition.posY + cell.y,
      );
    }).toList();
  }

  static bool isWithinBoard(List<Position> positions, int boardSize) {
    return positions.every(
      (pos) =>
          pos.posX >= 0 &&
          pos.posX < boardSize &&
          pos.posY >= 0 &&
          pos.posY < boardSize,
    );
  }
}
