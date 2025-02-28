import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsWorkerScreen extends StatelessWidget {
  ReviewsWorkerScreen({super.key});

  final List<Map<String, dynamic>> reviews = [
    {
      "date": "18 de Jul. 2025",
      "client": "Rommel Canepa",
      "rating": 3.0,
      "comment": "No me gustó mucho la manera de comportarse, pero está dentro de lo normal",
      "response": [
        "Muchas gracias por tu recomendación.",
        "Esta persona trabaja muy bien.",
        "Muchas gracias por tu recomendación."
      ]
    },
    {
      "date": "18 de Jul. 2025",
      "client": "Kevin Montero",
      "rating": 4.0,
      "comment": "Me gustó mucho como realizó su servicio",
      "response": [
        "Muchas gracias por tu recomendación.",
        "Esta persona trabaja muy bien.",
        "Muchas gracias por tu recomendación."
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'Reseñas sobre el cliente',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          // Apartado verde con nombre e imagen del trabajador
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[700],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile_image.png'),
                ),
                SizedBox(height: 12),
                Text(
                  'Delmy Arellano',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'uwu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Lista de reseñas
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return _buildReviewCard(reviews[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review["date"],
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              review["client"],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  "${review["rating"]} / 5",
                  style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review["comment"],
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),
            ...review["response"].map<Widget>((response) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      response,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 12),
            const Row(
              children: [
                Icon(Icons.search, size: 16, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  "Comentar",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}