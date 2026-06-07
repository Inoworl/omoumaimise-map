import 'package:flutter/material.dart';

void main() {
  runApp(const OmoumaiApp());
}

class OmoumaiApp extends StatelessWidget {
  const OmoumaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Omoumaimise Map',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const Scaffold(body: Center(child: Text('Hello world'))),
    );
  }
}
