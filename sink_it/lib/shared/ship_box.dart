//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';
import 'package:sink_it/models/ship/ship.dart';
import 'package:sink_it/shared/styled_text.dart';
import 'package:sink_it/theme.dart';

// box that shows boats available
class ShipBox extends StatelessWidget {
  const ShipBox({super.key, required this.ship, this.onTap, this.onDelete});

  final Ship ship;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.lightGray,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.directions_boat, color: AppTheme.textPrimary, size: 24),
            const SizedBox(width: 12),
            Expanded(child: StyledTitle(ship.name)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.darkBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: StyledText('${ship.size} tiles'),
            ),
            if (onDelete != null) ...[
              const SizedBox(width: 8),
              IconButton(
                onPressed: onDelete,
                icon: Icon(Icons.delete, color: AppTheme.primaryRed),
                iconSize: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
