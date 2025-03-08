import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Services/client_request/transaction/service_transaction_controller.dart';
import 'package:test_app/presentation/screens/stripe/keys.dart';
import 'package:test_app/presentation/screens/transferenciaespera_screen.dart';
import 'package:logger/logger.dart';

class HomePageStripe extends StatefulWidget {
  const HomePageStripe({super.key});
  @override
  State<HomePageStripe> createState() => _HomePageStripeState();
}

class _HomePageStripeState extends State<HomePageStripe> {
  final ServiceTransactionController controller =
      Get.find(); // Obtén el controlador
  Map<String, dynamic>? intentPaymentData;
  var logger = Logger();

  Future<void> showPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      // Si el pago fue exitoso, limpiar los datos y redirigir
      intentPaymentData = null;
      logger.i("Pago exitoso: Intento de pago limpiado");
      final paymentIntentId = controller.transaction.value.paymentIntentId;

      await fetchPaymentDetails(paymentIntentId); // Obtener el charge_id

      logger.i("Pago exitoso: Intento de pago limpiado y Charge ID obtenido.");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TransferenciaEsperaScreen()),
      );
    } on StripeException catch (error) {
      logger.e("Error de Stripe: $error");

      showDialog(
        context: context,
        builder: (c) => const AlertDialog(
          content: Text("Pago cancelado"),
        ),
      );
    } catch (error) {
      logger.e("Error al procesar el pago: $error");

      // Mostrar mensaje de error en la UI
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hubo un error al procesar el pago")),
      );
    }
  }

  Future<Map<String, dynamic>?> makeIntentForPayment(
      String amountToBeCharge, String currency) async {
    try {
      Map<String, dynamic> paymentInfo = {
        "amount": (int.parse(amountToBeCharge) * 100)
            .toString(), // Convertimos a centavos
        "currency": currency,
        "payment_method_types[]": "card",
      };

      var responseFromStripeAPI = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentInfo,
        headers: {
          "Authorization": "Bearer $claveSecreta",
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );

      var responseData = jsonDecode(responseFromStripeAPI.body);

      if (responseData.containsKey("id")) {
        controller.setPaymentId(responseData["id"]); // Guardamos el Payment ID
      }

      logger.i("Respuesta de Stripe: ${responseFromStripeAPI.body}");
      return responseData;
    } catch (errorMsg) {
      logger.e("Error en la solicitud de pago: $errorMsg");
      return null;
    }
  }

  Future<void> paymentSheetInitialization(
      BuildContext context, String amountToBeCharge, String currency) async {
    try {
      logger.i(
          "Iniciando la hoja de pago con monto: $amountToBeCharge $currency");

      intentPaymentData =
          await makeIntentForPayment(amountToBeCharge, currency);
      logger.i("Intento de pago generado: ${intentPaymentData!["id"]}");

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: intentPaymentData!["client_secret"],
          style: ThemeMode.dark,
          merchantDisplayName: "Keidot App",
        ),
      );

      logger.i("Hoja de pago inicializada correctamente.");
      showPaymentSheet(context); // Pasamos el contexto aquí
    } catch (errorMsg, s) {
      logger.e("Error en la inicialización del pago: $errorMsg",
          error: errorMsg, stackTrace: s);
    }
  }

//Metodo para obtener el charge_id una vez ya se haya generado en Stripe
  Future<void> fetchPaymentDetails(String paymentIntentId) async {
    try {
      var response = await http.get(
        Uri.parse("https://api.stripe.com/v1/payment_intents/$paymentIntentId"),
        headers: {
          "Authorization": "Bearer $claveSecreta",
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );

      var responseData = jsonDecode(response.body);

      if (responseData.containsKey("latest_charge")) {
        String chargeId = responseData["latest_charge"];
        controller.setChargeId(chargeId); // Guardamos el charge ID
        logger.i("Charge ID guardado: $chargeId");
      }
    } catch (error) {
      logger.e("Error obteniendo detalles del pago: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<ServiceTransactionController>();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              final amount =
                  transactionController.transaction.value?.amount ?? 0.0;
              return ElevatedButton(
                onPressed: () {
                  paymentSheetInitialization(
                      context, amount.round().toString(), "MXN");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Pay Now \$${amount.toString()}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Regresa a la pantalla anterior
              },
              child: const Text(
                'Anterior',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
