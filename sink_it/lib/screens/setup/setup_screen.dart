import 'package:flutter/material.dart';
import 'package:sink_it/models/game_config.dart';
import 'package:sink_it/screens/player_setup_screen.dart';
import 'package:sink_it/screens/setup/setting_row.dart';
import 'package:sink_it/screens/setup/ship_box.dart';
import 'package:sink_it/shared/board_size_button.dart';
import 'package:sink_it/shared/create_boat_button.dart';
import 'package:sink_it/shared/styled_box.dart';
import 'package:sink_it/shared/styled_button.dart';
import 'package:sink_it/shared/styled_text.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int selectedBoardSize = 10;
  bool soundEnabled = true;
  bool animationsEnabled = true;
  late GameConfig config;

  @override
  void initState() {
    super.initState();
    config = GameConfig(
      boardSize: selectedBoardSize,
      soundEnabled: soundEnabled,
      animationsEnabled: animationsEnabled,
    );
  }

  void updateBoardSize(int size) {
    setState(() {
      selectedBoardSize = size;
      config = GameConfig(
        boardSize: size,
        soundEnabled: soundEnabled,
        animationsEnabled: animationsEnabled,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: StyledHeading('Game Setup')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              //Board zise setting
              SectionBox(
                title: StyledTitle('Board Size'),
                child: Row(
                  children: [
                    BoardSizeButton(
                      size: '8x8',
                      label: 'Quick Game',
                      isSelected: selectedBoardSize == 8,
                      onPressed: () => updateBoardSize(8),
                    ),
                    SizedBox(width: 30),
                    BoardSizeButton(
                      size: '10x10',
                      label: 'Classic Game',
                      isSelected: selectedBoardSize == 10,
                      onPressed: () => updateBoardSize(10),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              // Fleet Composition
              SectionBox(
                title: StyledTitle('Fleet Composition'),
                child: Column(
                  children: config.fleet.map((ship) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ShipBox(ship: ship, onTap: () {}),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 15),

              //Game Options
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
                      initialValue: soundEnabled,
                      onChanged: (value) => setState(() {
                        soundEnabled = value;
                      }),
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
                      initialValue: animationsEnabled,
                      onChanged: (value) => setState(() {
                        animationsEnabled = value;
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              //next btn
              PrimaryButton(
                onPressed: () {
                  GameConfig config = GameConfig(
                    boardSize: selectedBoardSize,
                    soundEnabled: soundEnabled,
                    animationsEnabled: animationsEnabled,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => PlayerSetupScreen(gameConfig: config),
                    ),
                  );
                },
                child: StyledTitle('Lat\'s place some ships!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
