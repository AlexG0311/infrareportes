import 'package:flutter/material.dart';
import 'report_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infrasol'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Reportar un problema'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReportScreen()),
            );
          },
        ),
      ),
    );
  }
}
