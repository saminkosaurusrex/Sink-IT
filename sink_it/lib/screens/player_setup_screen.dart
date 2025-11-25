//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
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

// ✅ Provider pre edit mode
final isEditingNameProvider = StateProvider<bool>((ref) => false);

// ✅ ZMEŇ NA ConsumerStatefulWidget
class PlayerSetupScreen extends ConsumerStatefulWidget {
  const PlayerSetupScreen({super.key});

  @override
  ConsumerState<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends ConsumerState<PlayerSetupScreen> {
  late TextEditingController _nameController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameConfig = ref.watch(gameConfigControllerProvider);
    final placementController = ref.read(shipPlacementProvider.notifier);
    final placementState = ref.watch(shipPlacementProvider);
    final isSubmitting = ref.watch(isSubmittingProvider);

    final currentPlayerName = ref.watch(currentPlayerNameProvider);
    final isEditingName = ref.watch(isEditingNameProvider);

    // Update controller when name changes
    if (_nameController.text != currentPlayerName && !isEditingName) {
      _nameController.text = currentPlayerName;
    }

    return Scaffold(
      appBar: AppBar(
        title: isEditingName
            ? TextField(
                controller: _nameController,
                focusNode: _focusNode,
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter player name',
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    ref
                        .read(gameStateProvider.notifier)
                        .updatePlayerName(value.trim());
                  }
                  ref.read(isEditingNameProvider.notifier).state = false;
                },
              )
            : Text('$currentPlayerName Setup'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isEditingName ? Icons.check : Icons.edit),
            onPressed: () {
              if (isEditingName) {
                final newName = _nameController.text.trim();
                if (newName.isNotEmpty) {
                  ref
                      .read(gameStateProvider.notifier)
                      .updatePlayerName(newName);
                }
                ref.read(isEditingNameProvider.notifier).state = false;
              } else {
                _nameController.text = currentPlayerName;
                ref.read(isEditingNameProvider.notifier).state = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _focusNode.requestFocus();
                });
              }
            },
            tooltip: isEditingName ? 'Confirm' : 'Edit player name',
          ),
        ],
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
                            await placementController.submitShips();
                            final gameReady = ref.watch(
                              allPLayersReadyProvider,
                            );
                            if (gameReady) {
                              final gameStateController = ref.read(
                                gameStateProvider.notifier,
                              );
                              gameStateController.startGame();

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
