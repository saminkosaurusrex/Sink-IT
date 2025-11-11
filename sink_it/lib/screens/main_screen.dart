import 'package:flutter/material.dart';
import 'package:sink_it/screens/setup/setup_screen.dart';
import 'package:sink_it/shared/styled_button.dart';
import 'package:sink_it/shared/styled_text.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              Image.asset('assets/img/logo.png', width: 350, height: 350),

              const StyledName('Sink IT!'),

              const SizedBox(height: 8),

              const StyledTitle('Local 1v1 Combat'),

              const Spacer(flex: 3),

              PrimaryButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const SetupScreen()),
                  );
                },
                child: const StyledHeading('Start New Game'),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
