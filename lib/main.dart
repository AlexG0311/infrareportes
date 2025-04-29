import 'package:flutter/material.dart';
import 'package:infrareportes/screen/report_screen.dart';

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
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            }),
      ),
    );
  }
}
