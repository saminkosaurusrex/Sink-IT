//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:sink_it/models/position.dart';
import 'package:sink_it/models/ship/ship.dart';

class ShipShapeHelper {
  static Ship normalizeAndValidate(List<Position> cells) {
    if (cells.isEmpty) {
      return Ship(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'New Boat',
        shape: [],
      );
    }

    // Normalize
    int minX = cells.map((c) => c.posX).reduce((a, b) => a < b ? a : b);
    int minY = cells.map((c) => c.posY).reduce((a, b) => a < b ? a : b);

    List<Position> normalized = cells.map((cell) {
      return Position(posX: cell.posX - minX, posY: cell.posY - minY);
    }).toList();

    // Validation
    if (!areAllCellsConnected(normalized)) {
      throw Exception('Ship cells must be connected!');
    }

    return Ship(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'New Boat',
      shape: normalized,
    );
  }

  //check if all cells are connected
  static bool areAllCellsConnected(List<Position> cells) {
    if (cells.isEmpty) return true;
    if (cells.length == 1) return true;

    Set<String> visited = {};
    Set<String> allCells = cells.map((c) => '${c.posX},${c.posY}').toSet();

    void dfs(Position cell) {
      String key = '${cell.posX},${cell.posY}';
      if (visited.contains(key)) return;
      visited.add(key);

      // check all sides
      List<Position> neighbors = [
        Position(posX: cell.posX - 1, posY: cell.posY),
        Position(posX: cell.posX + 1, posY: cell.posY),
        Position(posX: cell.posX, posY: cell.posY - 1),
        Position(posX: cell.posX, posY: cell.posY + 1),
      ];

      for (var neighbor in neighbors) {
        String neighborKey = '${neighbor.posX},${neighbor.posY}';
        if (allCells.contains(neighborKey)) {
          dfs(neighbor);
        }
      }
    }

    dfs(cells.first);
    return visited.length == cells.length;
  }
}
