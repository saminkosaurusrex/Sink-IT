//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:sink_it/models/ship/shape_cell.dart';
import 'package:sink_it/models/ship/ship.dart';

class ShipShapeHelper {
  static Ship normalizeAndValidate(List<ShapeCell> cells) {
    if (cells.isEmpty) {
      return Ship(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'New Boat',
        shape: [],
      );
    }

    // Normalize
    int minX = cells.map((c) => c.x).reduce((a, b) => a < b ? a : b);
    int minY = cells.map((c) => c.y).reduce((a, b) => a < b ? a : b);

    List<ShapeCell> normalized = cells.map((cell) {
      return ShapeCell(x: cell.x - minX, y: cell.y - minY);
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

  static bool areAllCellsConnected(List<ShapeCell> cells) {
    if (cells.isEmpty) return true;
    if (cells.length == 1) return true;

    Set<String> visited = {};
    Set<String> allCells = cells.map((c) => '${c.x},${c.y}').toSet();

    void dfs(ShapeCell cell) {
      String key = '${cell.x},${cell.y}';
      if (visited.contains(key)) return;
      visited.add(key);

      // check all sides
      List<ShapeCell> neighbors = [
        ShapeCell(x: cell.x - 1, y: cell.y),
        ShapeCell(x: cell.x + 1, y: cell.y),
        ShapeCell(x: cell.x, y: cell.y - 1),
        ShapeCell(x: cell.x, y: cell.y + 1),
      ];

      for (var neighbor in neighbors) {
        String neighborKey = '${neighbor.x},${neighbor.y}';
        if (allCells.contains(neighborKey)) {
          dfs(neighbor);
        }
      }
    }

    dfs(cells.first);
    return visited.length == cells.length;
  }
}
