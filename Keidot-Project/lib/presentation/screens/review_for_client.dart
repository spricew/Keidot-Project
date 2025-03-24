import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/Services/client_request/review_of_worker/review_workerController.dart';
import 'package:test_app/config/theme/app_theme.dart';

class ReviewsForClientScreen extends StatefulWidget {


  const ReviewsForClientScreen({super.key});

  @override
  State<ReviewsForClientScreen> createState() => _ReviewsForClientScreenState();
}

class _ReviewsForClientScreenState extends State<ReviewsForClientScreen> {
  final ReviewForClientController reviewController = Get.put(ReviewForClientController());

  @override
  void initState() {
    super.initState();
    reviewController.fetchReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        title: const Text(
          'Reseñas sobre el trabajador',
          style: TextStyle(
            color: greenHigh,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          // Cabecera con nombre e imagen
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
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/profile_image.png'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Trabajador especializado',
                  style: TextStyle(
                    color: defaultWhite,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Obx(() {
              if (reviewController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (reviewController.reviews.isEmpty) {
                return const Center(
                  child: Text("Aún no hay reseñas disponibles"),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: reviewController.reviews.length,
                itemBuilder: (context, index) {
                  final review = reviewController.reviews[index];
                  return _buildReviewCard(
                    review['review_date'] ?? '',
                    review['nameClient'] ?? 'Cliente desconocido',
                    review['rating'] ?? 0,
                    review['comment_at'] ?? '',
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(String date, String client, int rating, String comment) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            const SizedBox(height: 8),
            Text(client, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text("$rating / 5", style: TextStyle(fontSize: 14, color: Colors.grey[800])),
              ],
            ),
            const SizedBox(height: 12),
            Text(comment, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
