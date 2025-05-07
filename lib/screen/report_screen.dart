import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  // ignore: unused_field
  String _description = '';
  String _problemType = 'Hueco en la vía';

  final List<String> _problemTypes = [
    'Hueco en la vía',
    'Alumbrado público dañado',
    'Fuga de agua',
    'Tapa de alcantarilla rota',
    'Otro'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Reporte')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                decoration:
                    const InputDecoration(labelText: 'Tipo de problema'),
                value: _problemType,
                items: _problemTypes
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _problemType = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descripción del problema',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) => value == null || value.isEmpty
                    ? 'Por favor escribe una descripción'
                    : null,
                onSaved: (value) => _description = value ?? '',
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Aquí se enviará el reporte más adelante
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Reporte enviado (simulado)')),
                    );
                  }
                },
                child: const Text('Enviar reporte'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
