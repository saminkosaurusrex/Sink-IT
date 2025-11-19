//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sink_it/providers/ship_editor_provider.dart';
import 'package:sink_it/shared/styled_text.dart';
import 'package:sink_it/theme.dart';

/// Čistý widget pre editáciu tvaru lode
/// Žiadna logika - iba zobrazenie a volanie Controller metód
class ShipShapeEditor extends ConsumerWidget {
  final int gridSize;
  final int maxTiles;

  const ShipShapeEditor({super.key, this.gridSize = 5, this.maxTiles = 5});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editor = ref.watch(shipEditorProvider);
    final controller = ref.read(shipEditorProvider.notifier);

    if (editor == null) {
      return Center(child: StyledText('No ship selected for editing'));
    }

    final currentTiles = editor.shape.length;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Názov lode
        TextField(
          controller: TextEditingController(text: editor.name)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: editor.name.length),
            ),
          onChanged: controller.setName,
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: 'Boat name',
            hintStyle: TextStyle(color: AppTheme.textSecondary),
            filled: true,
            fillColor: AppTheme.lightGray,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppTheme.primaryRed, width: 2),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        SizedBox(height: 16),

        // Info riadok
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StyledText('$currentTiles/$maxTiles tiles'),
            TextButton(
              onPressed: currentTiles > 0 ? controller.clearShape : null,
              style: TextButton.styleFrom(
                foregroundColor: AppTheme.primaryRed,
                disabledForegroundColor: AppTheme.textSecondary,
              ),
              child: Text(
                'Clear',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),

        // Grid
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.lightGray, width: 2),
              boxShadow: AppTheme.cardShadow,
            ),
            padding: EdgeInsets.all(8),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridSize,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: gridSize * gridSize,
              itemBuilder: (context, index) {
                final x = index % gridSize;
                final y = index ~/ gridSize;
                final isSelected = controller.isCellSelected(x, y);
                final canAdd = currentTiles < maxTiles || isSelected;

                return GestureDetector(
                  onTap: canAdd ? () => controller.toggleCell(x, y) : null,
                  child: AnimatedContainer(
                    duration: AppTheme.shortAnimation,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryRed
                          : canAdd
                          ? AppTheme.lightGray
                          : AppTheme.mediumGray,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primaryRed.withAlpha(200)
                            : AppTheme.gridLineColor,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppTheme.primaryRed.withAlpha(100),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                    ),
                    child: !canAdd
                        ? Center(
                            child: Icon(
                              Icons.lock,
                              size: 16,
                              color: AppTheme.textSecondary,
                            ),
                          )
                        : isSelected
                        ? Center(
                            child: Icon(
                              Icons.done,
                              size: 16,
                              color: AppTheme.textPrimary,
                            ),
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
