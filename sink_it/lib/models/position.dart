class Position {
  final int posX;
  final int posY;

  Position({required this.posX, required this.posY});

  Map<String, dynamic> toJson() => {'posX': posX, 'posY': posY};
}
