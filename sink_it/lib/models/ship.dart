import 'package:sink_it/models/position.dart';

class Ship {
  final String id;
  final String name;
  final List<Position> positions;

  Ship({required this.id, required this.name, required this.positions});
}
