import 'package:flutter/material.dart';
import 'package:sink_it/theme.dart';

class CreateBoatButton extends StatelessWidget {
  const CreateBoatButton({
    required this.child,
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.mediumGray,
          foregroundColor: AppTheme.lightGray,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: child,
      ),
    );
  }
}
