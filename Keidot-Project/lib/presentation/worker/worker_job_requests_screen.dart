import 'package:flutter/material.dart';

class WorkerJobRequestsScreen extends StatelessWidget {
  const WorkerJobRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trabajos Disponibles',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5, // Número de trabajos de ejemplo
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.work, color: Colors.green, size: 30),
              title: Text(
                "Trabajo ${index + 1}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text(
                "Ubicación: Ciudad\nPago: \$500",
                style: TextStyle(fontSize: 16),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  // Acción de aceptar trabajo (pendiente de lógica)
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  "Aceptar",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
