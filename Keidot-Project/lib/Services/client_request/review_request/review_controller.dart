import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test_app/Services/client_request/assignment_request/assignment_controller.dart';
import 'package:test_app/Services/models/review_model.dart';


class ReviewController extends GetxController {
  final Logger _logger = Logger();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  var rating = 5.obs; // Valor por defecto
  var urlImagen = 'ambientedeprueba.com'.obs; // Valor por defecto vacío
  var commentAt = ''.obs;

  void setRating(int value) {
    rating.value = value;
  }

  void setUrlImagen(String url) {
    urlImagen.value = url.isNotEmpty ? url : "https://default.com/default-image.jpg";
  }

  void setCommentAt(String comment) {
    commentAt.value = comment;
  }

  /// Método para enviar la reseña a la API mediante POST
  Future<bool> sendReview() async {
    const String apiUrl = 'https://keidot.azurewebsites.net/api/Reviews';
    final String? token = await storage.read(key: 'token');

    if (token == null) {
      _logger.e("Error: Token no encontrado");
      return false;
    }

    //final AssignmentIdController assignmentController = Get.find<AssignmentIdController>(); 
    //String? assignmentId = assignmentController.selectedAssignmentId;

final String assignmentId = "01957d08-5529-7875-822e-4a371dad6a54";
    /*if (assignmentId == null || assignmentId.isEmpty) {
      _logger.e("Error: No se encontró el assignment_id");
      return false;
    }*/
////////////////////////////////////////////////////////////////////////////////////////////////////quitaar comentarios, es para pruebas
    final review = {
      "assignment_id": assignmentId.isEmpty ? assignmentId : "01957d08-5529-7875-822e-4a371dad6a54", 
      ...ReviewModel(
        rating: rating.value,
        urlImagen: urlImagen.value,
        commentAt: commentAt.value,
      ).toJson(),
    };
    _logger.i("Enviando JSON: ${jsonEncode(review)}");

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(review),
      );

      _logger.i("Respuesta del servidor: ${response.statusCode}, ${response.body}");

      if (response.statusCode == 201) {
        _logger.i("Reseña enviada con éxito.");
        return true;
      } else {
        _logger.w("Error en la solicitud. Código: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      _logger.e("Error al enviar la reseña", error: e);
      return false;
    }
  }
}
