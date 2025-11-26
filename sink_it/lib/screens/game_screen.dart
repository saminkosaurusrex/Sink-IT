//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sink_it/enums/cell_state.dart';
import 'package:sink_it/models/position.dart';
import 'package:sink_it/providers/game_play_provider.dart';
import 'package:sink_it/providers/game_state_provider.dart';
import 'package:sink_it/screens/win_screen.dart';
import 'package:sink_it/shared/game_board.dart';
import 'package:sink_it/shared/styled_text.dart';
import 'package:sink_it/theme.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameStateProvider);
    final gamePlayState = ref.watch(gamePlayProvider);
    final isAttacking = ref.watch(isAttackingProvider);

    ref.listen(gameStateProvider, (previous, next) {
      if (next != null && next.winnerId != null && context.mounted) {
        final winner = next.winnerId == next.player1?.id
            ? next.player1!
            : next.player2!;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => WinScreen(name: winner.name)),
        );
      }
    });

    if (game == null || game.player1 == null || game.player2 == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Game Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StyledText('Game not found!'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back to Setup'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      body: SafeArea(
        child: Column(
          children: [
            //player2
            Expanded(
              child: _buildPlayerSection(
                context: context,
                ref: ref,
                player: game.player2!,
                cellStates: gamePlayState.opponentBoard,
                isCurrentPlayer: game.currentPlayerIndex == 1,
                isAttacking: isAttacking,
                rotated: true,
                showShips: false,
              ),
            ),

            // divider
            Container(
              height: 4,
              color: AppTheme.missWhite,
              margin: EdgeInsets.symmetric(vertical: 8),
            ),

            //player1
            Expanded(
              child: _buildPlayerSection(
                context: context,
                ref: ref,
                player: game.player1!,
                cellStates: gamePlayState.playerBoard,
                isCurrentPlayer: game.currentPlayerIndex == 0,
                isAttacking: isAttacking,
                rotated: false,
                showShips: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper: Sekcia pre jedného hráča
  Widget _buildPlayerSection({
    required BuildContext context,
    required WidgetRef ref,
    required dynamic player,
    required Map<Position, CellState> cellStates,
    required bool isCurrentPlayer,
    required bool isAttacking,
    required bool rotated,
    bool showShips = false,
  }) {
    final game = ref.read(gameStateProvider)!;

    return Transform.rotate(
      angle: rotated ? 3.14159 : 0,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isCurrentPlayer
              ? AppTheme.primaryRed.withAlpha(50)
              : AppTheme.cardBackground,
          border: Border.all(
            color: isCurrentPlayer ? AppTheme.primaryRed : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header player name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: isCurrentPlayer
                      ? AppTheme.yellowGold
                      : AppTheme.textSecondary,
                  size: 24,
                ),
                SizedBox(width: 8),
                StyledText(player.name),
                if (isCurrentPlayer && isAttacking)
                  Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppTheme.primaryRed,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 12),

            // Board
            Expanded(
              child: GameBoard(
                boardSize: game.config.boardSize,
                cellStates: cellStates,
                onCellTap: isCurrentPlayer && !isAttacking
                    ? (position) => _handleAttack(context, ref, position)
                    : null,
                interactive: isCurrentPlayer && !isAttacking,
                showShips: showShips,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper: Spracuj útok
  void _handleAttack(BuildContext context, WidgetRef ref, Position position) {
    final gamePlayController = ref.read(gamePlayProvider.notifier);

    gamePlayController
        .attack(position)
        .then((_) {
          final result = ref.read(lastAttackResultProvider);
          if (context.mounted && result != null && result.contains('sunk')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(result),
                backgroundColor: Colors.orange,
                duration: Duration(seconds: 1),
              ),
            );
          }
        })
        .catchError((e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Attack failed: $e'),
                backgroundColor: AppTheme.hitRed,
                duration: Duration(seconds: 1),
              ),
            );
          }
        });
  }
}
