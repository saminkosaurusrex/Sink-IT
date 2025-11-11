import 'package:flutter/material.dart';
import 'package:sink_it/theme.dart';

class SectionBox extends StatelessWidget {
  const SectionBox({super.key, required this.title, required this.child});

  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppTheme.mediumGray, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [title, const SizedBox(height: 16), child],
      ),
    );
  }
}
