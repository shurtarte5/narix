import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const NarixApp());
}

class NarixApp extends StatelessWidget {
  const NarixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Narix',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
