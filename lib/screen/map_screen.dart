import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Reportes'),
      ),
      body: const Center(
        child: Text(
          'Aquí se mostrará el mapa con todos los reportes georreferenciados.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
