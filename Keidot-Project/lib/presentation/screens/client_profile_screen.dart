import 'package:flutter/material.dart';
import 'package:test_app/config/theme/app_theme.dart';

class ClientProfileScreen extends StatelessWidget {
  ClientProfileScreen({super.key});

  // Simulación de datos que vendrían de la API
  final List<Map<String, dynamic>> reviews = [
    {
      "name": "Heyder Momichis",
      "date": "18 de Jul. 2024",
      "rating": 4,
      "comment": "El trabajador cumple bien con sus servicios."
    },
    {
      "name": "Heyder Momichis",
      "date": "22 de Jul. 2024",
      "rating": 5,
      "comment": "Excelente trabajo, muy puntual y profesional."
    },
    {
      "name": "Heyder Momichis",
      "date": "25 de Jul. 2024",
      "rating": 3,
      "comment": "Buen servicio, pero podría mejorar en tiempos de respuesta."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultWhite,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(color: greenContrast),
                  padding: const EdgeInsets.all(12.0),
                  child: const Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 50, color: darkGreen),
                      ),
                      SizedBox(width: 12),
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
                const Text(
                  'Historial de servicios',
                  style: TextStyle(fontSize: 20, color: darkGreen),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildReviewCard(reviews[index]),
              childCount: reviews.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 21),
      decoration: const BoxDecoration(
        color: defaultWhite,
        border: Border(
          top: BorderSide(
            width: 1,
            color:
                Color.fromARGB(255, 201, 201, 201), // Color del borde superior
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 25, color: darkGreen),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(review["date"],
                      style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(
                    5,
                    (i) => Icon(
                          i < review["rating"] ? Icons.star : Icons.star_border,
                          color: darkGreen,
                          size: 16,
                        )),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(review["comment"], style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 8),
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
