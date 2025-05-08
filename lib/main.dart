import 'package:flutter/material.dart';
import 'package:infrareportes/screen/home_screen.dart';

void main() {
  runApp(const InfrasolApp());
}

class InfrasolApp extends StatelessWidget {
  const InfrasolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infrasol',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


