//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sink_it/providers/game_config_provider.dart';
import 'package:sink_it/providers/game_state_provider.dart';
import 'package:sink_it/providers/ship_editor_provider.dart';
import 'package:sink_it/screens/player_setup_screen.dart';
import 'package:sink_it/screens/setup/setting_row.dart';
import 'package:sink_it/screens/setup/ship_box.dart';
import 'package:sink_it/shared/board_size_button.dart';
import 'package:sink_it/shared/ship_shape_editor.dart';
import 'package:sink_it/shared/styled_box.dart';
import 'package:sink_it/shared/styled_button.dart';
import 'package:sink_it/shared/styled_text.dart';
import 'package:sink_it/theme.dart';

/// FRONTEND - Setup obrazovka pre konfiguráciu hry
/// Všetka logika je v provideroch, UI len zobrazuje a volá API
class SetupScreen extends ConsumerWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sledovanie stavu z providerov
    final currentBoardSize = ref.watch(boardSizeProvider);
    final currentSoundEnabled = ref.watch(soundEnabledProvider);
    final currentAnimationsEnabled = ref.watch(animationsEnabledProvider);
    final currentConfig = ref.watch(gameConfigControllerProvider);
    final currentEditingShip = ref.watch(shipEditorProvider);

    // Controllery pre volanie BE API
    final configController = ref.read(gameConfigControllerProvider.notifier);
    final editorController = ref.read(shipEditorProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: StyledHeading('Game Setup')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // ===== BOARD SIZE =====
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

              // ===== FLEET COMPOSITION (Custom Lodě) =====
              SectionBox(
                title: StyledTitle(
                  'Fleet Composition (${currentConfig.fleet.length})',
                ),
                child: Column(
                  children: [
                    // Ak NIE je editovaná žiadna loď, zobraz zoznam
                    if (currentEditingShip == null) ...[
                      // Zoznam lodí
                      ...currentConfig.fleet.map((ship) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: ShipBox(
                            ship: ship,
                            onTap: () {
                              // Začni editáciu existujúcej lode
                              editorController.startEditShip(ship);
                            },
                            onDelete: () {
                              // Vymaž loď z flotily
                              configController.removeShip(ship.id);
                            },
                          ),
                        );
                      }),

                      // Tlačidlo Add Ship
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: PrimaryButton(
                          onPressed: () {
                            // Začni editáciu novej lode
                            editorController.startNewShip();
                          },
                          child: StyledTitle('Add Ship'),
                        ),
                      ),
                    ],

                    // Ak JE editovaná loď, zobraz editor
                    if (currentEditingShip != null) ...[
                      ShipShapeEditor(maxTiles: 5),
                      SizedBox(height: 16),

                      // Tlačidlá Save / Cancel
                      Row(
                        children: [
                          // Cancel button
                          Expanded(
                            child: SecondaryButton(
                              text: "Cancel",
                              onPressed: () {
                                editorController.cancel();
                              },
                            ),
                          ),
                          SizedBox(width: 12),

                          // Save button
                          Expanded(
                            child: PrimaryButton(
                              onPressed: () {
                                final ship = editorController.getCurrentShip();

                                // Validácia
                                if (ship == null || ship.shape.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Add at least one tile!'),
                                      backgroundColor: AppTheme.hitRed,
                                    ),
                                  );
                                  return;
                                }

                                try {
                                  // Ak je loď už vo flotile, odstráň ju
                                  final existsInFleet = currentConfig.fleet.any(
                                    (s) => s.id == ship.id,
                                  );

                                  if (existsInFleet) {
                                    configController.removeShip(ship.id);
                                  }

                                  // Pridaj/aktualizuj loď cez Controller API
                                  configController.addShip(
                                    ship.shape,
                                    name: ship.name,
                                  );

                                  // Ukonči editáciu
                                  editorController.cancel();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                      backgroundColor: AppTheme.hitRed,
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

              // ===== GAME OPTIONS =====
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

              // ===== NEXT BUTTON =====
              // Zobraz len ak NIE je editácia
              if (currentEditingShip == null)
                PrimaryButton(
                  onPressed: () {
                    // Validácia - musí byť aspoň jedna loď
                    if (currentConfig.fleet.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Add at least one ship!'),
                          backgroundColor: AppTheme.hitRed,
                        ),
                      );
                      return;
                    }

                    // Získaj game state controller
                    final gameStateController = ref.read(
                      gameStateProvider.notifier,
                    );

                    // Zobraz loading dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (ctx) => Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryRed,
                        ),
                      ),
                    );

                    // Vytvor hru na serveri (async)
                    gameStateController
                        .createGame(currentConfig)
                        .then((_) {
                          // Úspech - zavri loading a naviguj
                          if (context.mounted) {
                            Navigator.pop(context); // Zavri loading

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => PlayerSetupScreen(),
                              ),
                            );
                          }
                        })
                        .catchError((e) {
                          // Chyba - zavri loading a zobraz error
                          if (context.mounted) {
                            Navigator.pop(context); // Zavri loading

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
