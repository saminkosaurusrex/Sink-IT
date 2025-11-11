class Position {
  final int posX;
  final int posY;

  Position({required this.posX, required this.posY});

  Map<String, dynamic> toJson() => {'posX': posX, 'posY': posY};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Position &&
          runtimeType == other.runtimeType &&
          posX == other.posX &&
          posY == other.posY;

  @override
  int get hashCode => posX.hashCode ^ posY.hashCode;
}
