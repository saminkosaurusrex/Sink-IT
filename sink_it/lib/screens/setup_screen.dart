//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sink_it/providers/game_config_provider.dart';
import 'package:sink_it/providers/game_state_provider.dart';
import 'package:sink_it/providers/ship_editor_provider.dart';
import 'package:sink_it/screens/player_setup_screen.dart';
import 'package:sink_it/shared/setting_row.dart';
import 'package:sink_it/shared/ship_box.dart';
import 'package:sink_it/shared/board_size_button.dart';
import 'package:sink_it/shared/ship_shape_editor.dart';
import 'package:sink_it/shared/styled_box.dart';
import 'package:sink_it/shared/styled_button.dart';
import 'package:sink_it/shared/styled_text.dart';
import 'package:sink_it/theme.dart';

class SetupScreen extends ConsumerWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBoardSize = ref.watch(boardSizeProvider);
    final currentSoundEnabled = ref.watch(soundEnabledProvider);
    final currentAnimationsEnabled = ref.watch(animationsEnabledProvider);
    final currentConfig = ref.watch(gameConfigControllerProvider);
    final currentEditingShip = ref.watch(shipEditorProvider);

    final configController = ref.read(gameConfigControllerProvider.notifier);
    final editorController = ref.read(shipEditorProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: StyledHeading('Game Setup')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              //Board size
              SectionBox(
                title: StyledTitle('Board Size'),
                child: Row(
                  children: [
                    BoardSizeButton(
                      size: '8x8',
                      label: 'Quick Game',
                      isSelected: currentBoardSize == 8,
                      onPressed: () => configController.setBoardSize(8),
                    ),
                    SizedBox(width: 30),
                    BoardSizeButton(
                      size: '10x10',
                      label: 'Classic Game',
                      isSelected: currentBoardSize == 10,
                      onPressed: () => configController.setBoardSize(10),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              //Fleet composition
              SectionBox(
                title: StyledTitle(
                  'Fleet Composition (${currentConfig.fleet.length})',
                ),
                child: Column(
                  children: [
                    // Warning
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: StyledText(
                          'Choose your ship shapes wisely — ships cannot be rotated later.',
                        ),
                      ),
                    ),

                    //ships not beeing edited
                    //collection encapsulation for widget to be placed in childre[]
                    if (currentEditingShip == null) ...[
                      ...currentConfig.fleet.map((ship) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ShipBox(
                            ship: ship,
                            onTap: () {
                              editorController.startEditShip(ship);
                            },
                            onDelete: () {
                              configController.removeShip(ship.id);
                            },
                          ),
                        );
                      }),

                      //Add ship btn
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: PrimaryButton(
                          onPressed: () {
                            editorController.startNewShip();
                          },
                          child: StyledTitle('Add Ship'),
                        ),
                      ),
                    ],

                    //
                    if (currentEditingShip != null) ...[
                      ShipShapeEditor(maxTiles: 5),
                      SizedBox(height: 16),

                      // save, cancel btn
                      Row(
                        children: [
                          // Cancel btn
                          Expanded(
                            child: SecondaryButton(
                              text: "Cancel",
                              onPressed: () {
                                editorController.cancel();
                              },
                            ),
                          ),
                          SizedBox(width: 12),

                          // Save btn
                          Expanded(
                            child: PrimaryButton(
                              onPressed: () {
                                final ship = editorController.getCurrentShip();

                                // Validation
                                if (ship == null || ship.shape.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Add at least one tile!'),
                                      backgroundColor: AppTheme.hitRed,
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                  return;
                                }

                                try {
                                  //remove ship from config if it already exists
                                  final existsInFleet = currentConfig.fleet.any(
                                    (s) => s.id == ship.id,
                                  );

                                  if (existsInFleet) {
                                    configController.removeShip(ship.id);
                                  }

                                  //add ship to config
                                  configController.addShip(
                                    ship.shape,
                                    name: ship.name,
                                  );

                                  //cancel edit
                                  editorController.cancel();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                      backgroundColor: AppTheme.hitRed,
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              child: StyledTitle('Save'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: 15),

              //game settings
              SectionBox(
                title: StyledTitle('Game Options'),
                child: Column(
                  children: [
                    // Sound Effects
                    SettingRow(
                      icon: Icon(
                        Icons.volume_up,
                        size: 40,
                        color: Colors.lightBlue,
                      ),
                      subtext: StyledText('Enable audio feedback'),
                      text: StyledTitle('Sound Effects'),
                      initialValue: currentSoundEnabled,
                      onChanged: configController.setSoundEnabled,
                    ),
                    SizedBox(height: 12),

                    // Animations
                    SettingRow(
                      icon: Icon(
                        Icons.auto_awesome,
                        size: 40,
                        color: Colors.amber,
                      ),
                      subtext: StyledText('Enable animations'),
                      text: StyledTitle('Animations'),
                      initialValue: currentAnimationsEnabled,
                      onChanged: configController.setAnimationsEnabled,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              //next btn
              if (currentEditingShip == null)
                PrimaryButton(
                  onPressed: () {
                    // checker for atleast 1 ship in config
                    if (currentConfig.fleet.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Add at least one ship!'),
                          backgroundColor: AppTheme.hitRed,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    final gameStateController = ref.read(
                      gameStateProvider.notifier,
                    );

                    // loading
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (ctx) => Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryRed,
                        ),
                      ),
                    );

                    //create game on server
                    gameStateController
                        .createGame(currentConfig)
                        .then((_) {
                          // success
                          if (context.mounted) {
                            //clsoe
                            Navigator.pop(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => PlayerSetupScreen(),
                              ),
                            );
                          }
                        })
                        .catchError((e) {
                          // error
                          if (context.mounted) {
                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to create game: $e'),
                                backgroundColor: AppTheme.hitRed,
                                duration: Duration(seconds: 4),
                              ),
                            );
                          }
                        });
                  },
                  child: StyledTitle('Let\'s place some ships!'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
