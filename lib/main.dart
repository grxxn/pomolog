import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pomolog/screens/main_screen.dart';

void main() async {
  await initializeDateFormatting('ko_KR');
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
