//Author: Samuel Kundrat
//Login: xkundrs00

import 'package:flutter/material.dart';
import 'package:sink_it/screens/main_screen.dart';
import 'package:sink_it/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MaterialApp(home: const MainScreen(), theme: AppTheme.darkTheme),
    ),
  );
}
