import 'package:flutter/material.dart';

void main() {
  runApp(const SyantiApp());
}

class SyantiApp extends StatelessWidget {
  const SyantiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'صيانتي',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('صيانتي'),
        ),
      ),
    );
  }
}
