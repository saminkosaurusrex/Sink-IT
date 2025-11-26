//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sink_it/providers/game_play_provider.dart';
import 'package:sink_it/providers/game_state_provider.dart';
import 'package:sink_it/shared/styled_button.dart';
import 'package:sink_it/shared/styled_text.dart';
import 'package:sink_it/theme.dart';

class WinScreen extends ConsumerWidget {
  final String name;
  const WinScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.read(gameStateProvider);
    final gamePlayState = ref.read(gamePlayProvider);

    final player1Name = game?.player1?.name ?? 'Player 1';
    final player2Name = game?.player2?.name ?? 'Player 2';

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: constraints.maxHeight < 700
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_events,
                            size: 120,
                            color: AppTheme.yellowGold,
                          ),

                          const SizedBox(height: 32),

                          StyledText('Victory!'),

                          const SizedBox(height: 16),

                          StyledHeading('$name rules the seas!'),

                          const SizedBox(height: 48),

                          // Stats card
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppTheme.cardBackground,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppTheme.lightGray,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              children: [
                                // Accuracy bars
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          StyledText(player1Name),
                                          const SizedBox(height: 8),
                                          LinearProgressIndicator(
                                            value:
                                                gamePlayState
                                                    .player1Stats
                                                    .accuracy /
                                                100,
                                            backgroundColor: Colors.grey[800],
                                            color: AppTheme.yellowGold,
                                            minHeight: 8,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${gamePlayState.player1Stats.accuracy.toStringAsFixed(1)}%',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(width: 24),

                                    Icon(
                                      Icons.track_changes,
                                      color: AppTheme.yellowGold,
                                      size: 32,
                                    ),

                                    const SizedBox(width: 24),

                                    Expanded(
                                      child: Column(
                                        children: [
                                          StyledText(player2Name),
                                          const SizedBox(height: 8),
                                          LinearProgressIndicator(
                                            value:
                                                gamePlayState
                                                    .player2Stats
                                                    .accuracy /
                                                100,
                                            backgroundColor: Colors.grey[800],
                                            color: AppTheme.yellowGold,
                                            minHeight: 8,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${gamePlayState.player2Stats.accuracy.toStringAsFixed(1)}%',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 24),

                                // Stats boxes
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildStatBox(
                                        player1Name,
                                        gamePlayState.player1Stats,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildStatBox(
                                        player2Name,
                                        gamePlayState.player2Stats,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                // Total turns
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      StyledTitle('Total turns'),
                                      const SizedBox(width: 16),
                                      StyledText('${gamePlayState.total}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 48),

                          // New game btn
                          PrimaryButton(
                            onPressed: () {
                              Future.delayed(
                                const Duration(milliseconds: 100),
                                () {
                                  ref
                                      .read(gameStateProvider.notifier)
                                      .resetGame();
                                  ref.read(gamePlayProvider.notifier).reset();
                                },
                              );
                              Navigator.of(
                                context,
                              ).popUntil((route) => route.isFirst);
                            },
                            child: StyledHeading('New Game'),
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatBox(String playerName, dynamic stats) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        children: [
          StyledTitle(playerName),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Hits', style: TextStyle(color: Colors.white70)),
              Text(
                '${stats.hits}',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Misses', style: TextStyle(color: Colors.white70)),
              Text(
                '${stats.misses}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white24, height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total', style: TextStyle(color: Colors.white)),
              Text(
                '${stats.total}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
