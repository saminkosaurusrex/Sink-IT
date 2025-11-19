import 'package:flutter/material.dart';
import 'package:sink_it/enums/cell_state.dart';
import 'package:sink_it/models/position.dart';
import 'package:sink_it/theme.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({
    super.key,
    required this.boardSize,
    required this.cellStates,
    this.onCellTap,
    this.interactive = true,
    this.showShips = true,
  });

  final int boardSize;
  final Map<Position, CellState> cellStates;
  final Function(Position)? onCellTap;
  final bool interactive;
  final bool showShips;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.lightGray, width: 2),
          boxShadow: AppTheme.cardShadow,
        ),
        child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: boardSize,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemCount: boardSize * boardSize,
          itemBuilder: (context, index) {
            final x = index % boardSize;
            final y = index ~/ boardSize;
            final position = Position(posX: x, posY: y);
            final cellState = cellStates[position] ?? CellState.empty;

            return GestureDetector(
              onTap: interactive && onCellTap != null
                  ? () => onCellTap!(position)
                  : null,
              child: AnimatedContainer(
                duration: AppTheme.shortAnimation,
                decoration: BoxDecoration(
                  color: _getCellColor(cellState),
                  border: Border.all(color: AppTheme.gridLineColor, width: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: _getCellContent(cellState),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getCellColor(CellState cellState) {
    switch (cellState) {
      case CellState.empty:
        return const Color.fromARGB(255, 54, 190, 208);
      case CellState.hit:
        return AppTheme.hitRed;
      case CellState.miss:
        return AppTheme.waterBlue.withAlpha(80);
      case CellState.ship:
        return showShips ? AppTheme.primaryRed : AppTheme.waterBlue;
    }
  }

  Widget? _getCellContent(CellState cellState) {
    if (cellState == CellState.miss) {
      return Center(
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppTheme.missWhite,
            shape: BoxShape.circle,
          ),
        ),
      );
    }
    if (cellState == CellState.hit) {
      return Center(
        child: Icon(Icons.close, color: AppTheme.textPrimary, size: 16),
      );
    }
    return null;
  }
}
