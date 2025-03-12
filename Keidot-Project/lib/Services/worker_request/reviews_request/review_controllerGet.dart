import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/worker_request/reviews_request/review_worker.dart';

class ReviewWorkerController extends GetxController {
  final ReviewWorkerService _reviewService = ReviewWorkerService();
  final Logger logger = Logger();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  // Lista de reseñas
  var reviews = <Map<String, dynamic>>[].obs;

  // Estado de carga
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadReview(); // Llama a la función al inicializarse el controlador
  }

  // Método para obtener y almacenar las reseñas
  Future<void> loadReview() async {
    isLoading.value = true;

    final dataList = await _reviewService.fetchReview();

    if (dataList != null && dataList.isNotEmpty) {
      // Asignar la lista de reseñas
      reviews.assignAll(dataList);
    } else {
      logger.e("No se encontraron reseñas");
    }

    isLoading.value = false;
  }
}