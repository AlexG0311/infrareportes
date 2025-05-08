import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas de Reportes'),
      ),
      body: const Center(
        child: Text(
          'Aquí se mostrarán gráficos y estadísticas sobre los reportes.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
