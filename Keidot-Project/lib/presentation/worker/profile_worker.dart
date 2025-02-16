import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/config/theme/app_theme.dart';

class WorkerProfileScreen extends StatelessWidget {
  WorkerProfileScreen({super.key});

  // Datos de api (chamba de Diego)
  final List<Map<String, dynamic>> publications = [
    {
      "name": "Heyder Mornichis",
      "rank": "#2 en AL 2025",
      "comment": "Buen trabajo, quisiera solicitar de tus servicios."
    },
    {
      "name": "Heyder Mornichis",
      "rank": "#3 en AL 2025",
      "comment": "Buen trabajo, quisiera solicitar de tus servicios."
    },
    {
      "name": "Heyder Mornichis",
      "rank": "#4 en AL 2025",
      "comment": "Buen trabajo, quisiera solicitar de tus servicios."
    },
    {
      "name": "Heyder Mornichis",
      "rank": "#5 en AL 2025",
      "comment": "Buen trabajo, quisiera solicitar de tus servicios."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Fondo blanco
        elevation: 0, // Sin sombra
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Botón de regreso
          onPressed: () => Get.back(), // Navegar hacia atrás
        ),
        centerTitle: true, // Centrar el título
        title: const Text(
          'Perfil del Trabajador', // Título centrado
          style: TextStyle(
            color: Color(0xFF3BA670), // Color del texto
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          // Perfil del trabajador
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: greenHigh),
            padding: const EdgeInsets.all(12.0),
            child: const Center( // Centrar el contenido del Container
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile_image.png'), // Cambia esto por la ruta de tu imagen
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Delmy',
                    style: TextStyle(
                        color: defaultWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          const SizedBox(
            width: double.infinity,
            child: Text(
              'Publicaciones sobre los trabajos de Delmy',
              textAlign: TextAlign.center, // Centrar el texto
              style: TextStyle(fontSize: 20, color: darkGreen),
            ),
          ),

          const SizedBox(height: 16),

          // Lista de publicaciones
          Expanded(
            child: ListView.builder(
              itemCount: publications.length, 
              itemBuilder: (context, index) {
                return _buildPublicationCard(publications[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPublicationCard(Map<String, dynamic> publication) {
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
                  Text(publication["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(publication["rank"],
                      style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(publication["comment"], style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
          // Espacio reservado para futura implementación
          const Row(
            children: [
              Icon(Icons.more, size: 16),
              SizedBox(width: 4),
              Text("Ver detalles"),
            ],
          ),
        ],
      ),
    );
  }
}