import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Usuario'),
      ),
      body: const Center(
        child: Text(
          'Aquí se podrá gestionar la información del perfil del usuario.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
