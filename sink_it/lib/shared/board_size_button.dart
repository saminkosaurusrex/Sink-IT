//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';
import 'package:sink_it/shared/styled_text.dart';
import 'package:sink_it/theme.dart';

// button for board zise
class BoardSizeButton extends StatelessWidget {
  const BoardSizeButton({
    super.key,
    required this.size,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String size;
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryRed : AppTheme.lightGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StyledTitle(size),
              const SizedBox(height: 4),
              StyledText(label),
            ],
          ),
        ),
      ),
    );
  }
}
