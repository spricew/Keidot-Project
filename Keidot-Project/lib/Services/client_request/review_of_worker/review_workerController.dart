import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app/Services/client_request/review_of_worker/worker_review.dart';

class ReviewForClientController extends GetxController {
  final Logger logger = Logger();
  final WorkerReviewForClient _reviewService = WorkerReviewForClient();

  RxBool isLoading = false.obs;
  RxList<Map<String, dynamic>> reviews = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      isLoading.value = true;
      final fetchedReviews = await _reviewService.fetchReview();

      if (fetchedReviews != null) {
        reviews.value = fetchedReviews;
      } else {
        logger.w("No se pudieron obtener las reseñas");
        reviews.clear();
      }
    } catch (e) {
      logger.e("Error al cargar reseñas: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
