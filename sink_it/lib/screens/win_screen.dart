//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sink_it/providers/game_play_provider.dart';
import 'package:sink_it/providers/game_state_provider.dart';
import 'package:sink_it/shared/styled_text.dart';
import 'package:sink_it/theme.dart';

class WinScreen extends ConsumerWidget {
  final String name;
  const WinScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_events, size: 120, color: AppTheme.yellowGold),

                const SizedBox(height: 32),

                StyledText('Victory!'),

                const SizedBox(height: 16),

                StyledHeading('$name wins!'),

                const SizedBox(height: 64),

                ElevatedButton(
                  onPressed: () {
                    Future.delayed(const Duration(milliseconds: 100), () {
                      ref.read(gameStateProvider.notifier).resetGame();
                      ref.read(gamePlayProvider.notifier).reset();
                    });
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryRed,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    minimumSize: const Size(200, 56),
                  ),
                  child: const Text(
                    'Back to Menu',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
