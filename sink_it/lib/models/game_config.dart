import 'package:sink_it/models/ship/ship.dart';
import 'package:sink_it/models/ship/shape_cell.dart';

class GameConfig {
  final int boardSize;
  final bool soundEnabled;
  final bool animationsEnabled;
  final List<Ship> fleet;

  int get maxFleetSize {
    if (boardSize == 8) return 3;
    if (boardSize == 10) return 5;
    return 5;
  }

  GameConfig({
    required this.boardSize,
    this.soundEnabled = true,
    this.animationsEnabled = true,
    List<Ship>? fleet,
  }) : fleet = fleet ?? [];

  static List<Ship> _getDefaultFleet(int boardSize) {
    if (boardSize == 8) {
      return [
        Ship(
          id: '1',
          name: 'Cruiser',
          shape: [
            ShapeCell(x: 0, y: 0),
            ShapeCell(x: 1, y: 0),
            ShapeCell(x: 2, y: 0),
          ],
        ),
        Ship(
          id: '2',
          name: 'Destroyer',
          shape: [ShapeCell(x: 0, y: 0), ShapeCell(x: 1, y: 0)],
        ),
      ];
    }

    return [
      Ship(
        id: '1',
        name: 'Carrier',
        shape: [
          ShapeCell(x: 0, y: 0),
          ShapeCell(x: 1, y: 0),
          ShapeCell(x: 2, y: 0),
          ShapeCell(x: 3, y: 0),
          ShapeCell(x: 4, y: 0),
        ],
      ),
      Ship(
        id: '2',
        name: 'Battleship',
        shape: [
          ShapeCell(x: 0, y: 0),
          ShapeCell(x: 1, y: 0),
          ShapeCell(x: 2, y: 0),
          ShapeCell(x: 3, y: 0),
        ],
      ),
      Ship(
        id: '3',
        name: 'L-Shape',
        shape: [
          ShapeCell(x: 0, y: 0),
          ShapeCell(x: 0, y: 1),
          ShapeCell(x: 0, y: 2),
          ShapeCell(x: 1, y: 2),
        ],
      ),
      Ship(
        id: '4',
        name: 'T-Shape',
        shape: [
          ShapeCell(x: 0, y: 0),
          ShapeCell(x: 1, y: 0),
          ShapeCell(x: 2, y: 0),
          ShapeCell(x: 1, y: 1),
        ],
      ),
      Ship(
        id: '5',
        name: 'Square',
        shape: [
          ShapeCell(x: 0, y: 0),
          ShapeCell(x: 1, y: 0),
          ShapeCell(x: 0, y: 1),
          ShapeCell(x: 1, y: 1),
        ],
      ),
    ];
  }

  Map<String, dynamic> toJson() => {
    'board_size': boardSize,
    'max_players': 2,
    'allow_custom_ships': false,
    'initial_spells': [],
  };
}
