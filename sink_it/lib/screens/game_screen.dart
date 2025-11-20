import 'package:flutter/material.dart';
import 'package:sink_it/shared/styled_text.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: StyledHeading('Hra')));
  }
}
