import 'package:flutter/material.dart';
import 'package:sink_it/screens/main_screen.dart';
import 'package:sink_it/theme.dart';
//import 'screens/splash_screen.dart';

void main() {
  runApp(MaterialApp(home: const MainScreen(), theme: AppTheme.darkTheme));
}

class SinkItApp extends StatelessWidget {
  const SinkItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
