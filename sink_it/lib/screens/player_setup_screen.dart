//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sink_it/enums/game_status.dart';
import 'package:sink_it/providers/game_config_provider.dart';
import 'package:sink_it/providers/game_state_provider.dart';
import 'package:sink_it/providers/ship_placement_provider.dart';
import 'package:sink_it/screens/game_screen.dart';
import 'package:sink_it/screens/setup/ship_box.dart';
import 'package:sink_it/shared/game_board.dart';
import 'package:sink_it/shared/styled_box.dart';
import 'package:sink_it/shared/styled_button.dart';
import 'package:sink_it/shared/styled_text.dart';
import 'package:sink_it/theme.dart';

class PlayerSetupScreen extends ConsumerWidget {
  const PlayerSetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameConfig = ref.watch(gameConfigControllerProvider);
    final placementController = ref.read(shipPlacementProvider.notifier);
    final placementState = ref.watch(shipPlacementProvider);
    final isSubmitting = ref.watch(isSubmittingProvider);

    final currentPlayerName = ref.watch(currentPlayerNameProvider);

    //final gameStateController = ref.read(gameStateProvider.notifier);
    //final currentPlayerIndex = ref.watch(currentPlayerIndexProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('$currentPlayerName Setup'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Fleet Composition
                  SectionBox(
                    title: StyledTitle('Fleet Composition'),
                    child: Column(
                      children: gameConfig.fleet.asMap().entries.map((entry) {
                        //final index = entry.key;
                        final ship = entry.value;
                        final isPlaced = placementController.isShipPlaced(
                          ship.id,
                        );
                        final isSelected =
                            placementState.selectedShip?.id == ship.id;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Opacity(
                            opacity: isPlaced ? 0.5 : 1.0,
                            child: Container(
                              decoration: BoxDecoration(
                                border: isSelected
                                    ? Border.all(
                                        color: AppTheme.primaryRed,
                                        width: 2,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ShipBox(
                                ship: ship,
                                onTap: () {
                                  placementController.selectShip(ship);
                                },
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Game Board
                  GameBoard(
                    boardSize: gameConfig.boardSize,
                    cellStates: placementController.getCellStates(),
                    onCellTap: (position) {
                      final result = placementController.placeShipAt(position);

                      if (!result && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Ships can\'t be that close!'),
                            backgroundColor: AppTheme.hitRed,
                          ),
                        );
                      }
                    },
                    interactive: true,
                    showShips: true,
                  ),

                  const SizedBox(height: 16),

                  // Submit Button
                  PrimaryButton(
                    onPressed: !isSubmitting && placementController.canSubmit()
                        ? () async {
                            // uloženie lodí do GameState
                            await placementController.submitShips();
                            final gameReady = ref.watch(
                              allPLayersReadyProvider,
                            );
                            if (gameReady) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Both players are ready!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (stx) => GameScreen(),
                                  ),
                                );
                              }
                            }
                          }
                        : null,
                    child: isSubmitting
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: AppTheme.textPrimary,
                              strokeWidth: 2,
                            ),
                          )
                        : StyledTitle('Submit Ships'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
