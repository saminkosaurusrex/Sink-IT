import 'package:flutter/material.dart';
import 'package:sink_it/helpers/ship_placement_helper.dart';
import 'package:sink_it/models/game_config.dart';
import 'package:sink_it/models/position.dart';
import 'package:sink_it/models/ship/ship.dart';
import 'package:sink_it/screens/setup/ship_box.dart';
import 'package:sink_it/shared/game_board.dart';
import 'package:sink_it/shared/styled_box.dart';
import 'package:sink_it/shared/styled_button.dart';
import 'package:sink_it/shared/styled_text.dart';
import 'package:sink_it/theme.dart';

class PlayerSetupScreen extends StatefulWidget {
  final GameConfig gameConfig;

  const PlayerSetupScreen({required this.gameConfig, super.key});

  @override
  State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  List<Ship> placedShips = [];
  Ship? selectedShip;
  int selectedShipIndex = 0;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    if (widget.gameConfig.fleet.isNotEmpty) {
      selectedShip = widget.gameConfig.fleet[0];
    }
  }

  void handleCellTap(Position position) {
    if (selectedShip == null) return;
    if (ShipPlacementHelper.canPlaceShip(
      selectedShip!,
      position,
      widget.gameConfig.boardSize,
      placedShips,
    )) {
      setState(() {
        final placedShip = ShipPlacementHelper.placeShip(
          selectedShip!,
          position,
        );

        final existingIndex = placedShips.indexWhere(
          (s) => s.id == selectedShip!.id,
        );
        if (existingIndex != -1) {
          placedShips[existingIndex] = placedShip;
        } else {
          placedShips.add(placedShip);
        }

        final nextUnplacedIndex = widget.gameConfig.fleet.indexWhere(
          (s) => !placedShips.any((ps) => ps.id == s.id),
        );

        if (nextUnplacedIndex != -1) {
          selectedShipIndex = nextUnplacedIndex;
          selectedShip = widget.gameConfig.fleet[selectedShipIndex];
        }
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ships cant\'t be that close!')));
    }
  }

  void handleDrop(Position position, Ship ship) {
    if (ShipPlacementHelper.canPlaceShip(
      ship,
      position,
      widget.gameConfig.boardSize,
      placedShips,
    )) {
      setState(() {
        final placedShip = ShipPlacementHelper.placeShip(ship, position);

        final existingIndex = placedShips.indexWhere((s) => s.id == ship.id);
        if (existingIndex != -1) {
          placedShips[existingIndex] = placedShip;
        } else {
          placedShips.add(placedShip);
        }
      });
    }
  }

  Map<Position, CellState> getCellState() {
    final Map<Position, CellState> states = {};
    for (var ship in placedShips) {
      for (var pos in ship.placedPositions) {
        states[pos] = CellState.ship;
      }
    }
    return states;
  }

  // Odstráň async z funkcie
  void submitShips() {
    _submitShipsAsync();
  }

  // Vytvor oddelenú async funkciu
  Future<void> _submitShipsAsync() async {
    setState(() => isSubmitting = true);

    try {
      // TODO: API calls
      await Future.delayed(Duration(seconds: 1)); // placeholder
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) {
        setState(() => isSubmitting = false);
      }
    }
  }

  void Function()? get submitShipsCallback {
    if (placedShips.length != widget.gameConfig.fleet.length) return null;
    return () {
      // TODO: Logic
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Player Setup'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SectionBox(
                    title: StyledTitle('Fleet Composition'),
                    child: Column(
                      children: widget.gameConfig.fleet.asMap().entries.map((
                        entry,
                      ) {
                        final index = entry.key;
                        final ship = entry.value;
                        final isPlaced = placedShips.any(
                          (s) => s.id == ship.id,
                        );
                        final isSelected = selectedShip?.id == ship.id;

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
                                  setState(() {
                                    selectedShip = ship;
                                    selectedShipIndex = index;
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  GameBoard(
                    boardSize: widget.gameConfig.boardSize,
                    cellStates: getCellState(),

                    onCellTap: handleCellTap,
                    interactive: true,
                    showShips: true,
                  ),

                  const SizedBox(height: 16),
                  PrimaryButton(
                    onPressed:
                        placedShips.length == widget.gameConfig.fleet.length
                        ? () {
                            submitShips();
                          }
                        : () {},
                    child: StyledTitle('Submit ships'),
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
