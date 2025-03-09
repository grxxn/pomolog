import 'package:flutter/material.dart';
import 'package:pomolog/screens/main_screen.dart';

void main() {
  runApp(const PomoLog());
}

class PomoLog extends StatelessWidget {
  const PomoLog({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MainScreen());
  }
}
