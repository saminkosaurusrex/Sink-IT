import 'package:flutter/material.dart';
import 'package:sink_it/screens/main_screen.dart';
import 'package:sink_it/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'screens/splash_screen.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(home: const MainScreen(), theme: AppTheme.darkTheme),
    ),
  );
}

class SinkItApp extends StatelessWidget {
  const SinkItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
