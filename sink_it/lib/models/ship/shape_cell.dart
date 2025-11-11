class ShapeCell {
  final int x;
  final int y;

  ShapeCell({required this.x, required this.y});

  @override
  bool operator ==(Object other) =>
      other is ShapeCell && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);
}
