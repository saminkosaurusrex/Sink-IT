//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';
import 'package:sink_it/providers/game_config_provider.dart';
import 'package:sink_it/providers/ship_editor_provider.dart';
import 'package:sink_it/screens/player_setup_screen.dart';
import 'package:sink_it/screens/setup/setting_row.dart';
import 'package:sink_it/screens/setup/ship_box.dart';
//import 'package:sink_it/screens/setup/ship_shape_editor.dart';
import 'package:sink_it/shared/board_size_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sink_it/shared/ship_shape_editor.dart';
import 'package:sink_it/shared/styled_box.dart';
import 'package:sink_it/shared/styled_button.dart';
import 'package:sink_it/shared/styled_text.dart';

class SetupScreen extends ConsumerWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sledovanie stavu
    final currentBoardSize = ref.watch(boardSizeProvider);
    final currentSoundEnabled = ref.watch(soundEnabledProvider);
    final currentAnimationsEnabled = ref.watch(animationsEnabledProvider);
    final currentConfig = ref.watch(gameConfigControllerProvider);
    final currentEditingShip = ref.watch(shipEditorProvider);

    // Controllery
    final configController = ref.read(gameConfigControllerProvider.notifier);
    final editorController = ref.read(shipEditorProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: StyledHeading('Game Setup')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Board size
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

              // Fleet Composition
              SectionBox(
                title: StyledTitle(
                  'Fleet Composition ${currentConfig.fleet.length}',
                ),
                child: Column(
                  children: [
                    // Ak nie je editovaná žiadna loď, zobraz zoznam
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

                    // Ak je editovaná loď, zobraz editor
                    if (currentEditingShip != null) ...[
                      ShipShapeEditor(maxTiles: 5),
                      SizedBox(height: 16),

                      // Tlačidlá Save / Cancel
                      Row(
                        children: [
                          Expanded(
                            child: SecondaryButton(
                              text: "Cancel",
                              onPressed: () {
                                editorController.cancel();
                              },
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: PrimaryButton(
                              onPressed: () {
                                final ship = editorController.getCurrentShip();
                                if (ship == null || ship.shape.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Add at least one tile!'),
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

                                  // Pridaj/aktualizuj loď cez Controller
                                  configController.addShip(
                                    ship.shape,
                                    name: ship.name,
                                  );

                                  // Ukonči editáciu
                                  editorController.cancel();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
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

              // Game options
              SectionBox(
                title: StyledTitle('Game Options'),
                child: Column(
                  children: [
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

              // Next button - iba ak nie je editácia
              if (currentEditingShip == null)
                PrimaryButton(
                  onPressed: () {
                    if (currentConfig.fleet.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Add at least one ship!')),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (ctx) => PlayerSetupScreen()),
                    );
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
