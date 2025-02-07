import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';

class ClientProfileScreen extends StatelessWidget {
  const ClientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultWhite,
      ),
      body: Column(
        children: [
          // Perfil del cliente
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: greenHigh),
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Colors.black87),
                ),
                const SizedBox(width: 12),
                Text(
                  'Heyder Momichis',
                  style: TextStyle(
                      color: defaultWhite,
                      fontWeight: FontWeight.w600,
                      fontSize: 22),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Título de la sección de comentarios
          Text(
            'Historial de servicios',
            style: TextStyle(fontSize: 20, color: darkGreen),
          ),

          const SizedBox(height: 16),

          // Lista de comentarios
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Número de reseñas
              itemBuilder: (context, index) {
                return _buildReviewCard();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: lightgreen,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado con nombre y fecha
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 25, color: Colors.black87),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Heyder Momichis",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "18 de Jul. 2024",
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ],
              ),
              const Spacer(),
              // Calificación con estrellas
              const Row(
                children: [
                  Text("4 / 5"),
                  SizedBox(width: 4),
                  Icon(Icons.star, color: Colors.black87, size: 16),
                  Icon(Icons.star, color: Colors.black87, size: 16),
                  Icon(Icons.star, color: Colors.black87, size: 16),
                  Icon(Icons.star, color: Colors.black87, size: 16),
                  Icon(Icons.star_border, color: Colors.black87, size: 16),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Comentario del usuario
          const Text(
            "El trabajador cumple bien con sus servicios.",
            style: TextStyle(fontSize: 14),
          ),

          const SizedBox(height: 8),

          // Botón de comentar
          Row(
            children: [
              const Icon(Icons.comment, size: 16),
              const SizedBox(width: 4),
              const Text("Comentar"),
            ],
          ),
        ],
      ),
    );
  }
}
