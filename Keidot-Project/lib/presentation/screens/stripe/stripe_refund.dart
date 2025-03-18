import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class PaymentRefundService {
  final String baseUrl = "https://keidotapi.azurewebsites.net/api/payments/refund";
  final Logger _logger = Logger();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  

  Future<Map<String, dynamic>> processRefund(String paymentIntentId) async {
    final Uri url = Uri.parse(baseUrl);
    final token = await storage.read(key: 'token');
    _logger.i("Token recuperado: $token");
    // Encabezados de la solicitud
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Token en el header
    };

    // Cuerpo de la solicitud
    final Map<String, dynamic> body = {
      "paymentIntentId": paymentIntentId,
      "reason": "requested_by_customer" // Razón válida para Stripe
    };

    try {
      _logger.i("Enviando solicitud de reembolso para PaymentIntent: $paymentIntentId");

      final http.Response response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );

      // Validar la respuesta
      if (response.statusCode == 200) {
        _logger.i("Reembolso exitoso: ${response.body}");
        Get.snackbar("Éxito", "El reembolso se ha procesado correctamente");
        return jsonDecode(response.body);
      } else {
        _logger.e("Error en el reembolso: ${response.statusCode} - ${response.body}");
        return {"success": false, "message": "Error en el reembolso: ${response.body}"};
      }
    } catch (e) {
      _logger.e("Excepción al procesar el reembolso: $e");
      return {"success": false, "message": "Excepción: $e"};
    }
  }
}
