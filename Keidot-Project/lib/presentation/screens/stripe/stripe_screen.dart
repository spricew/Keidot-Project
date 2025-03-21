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
  final ServiceTransactionController controller = Get.find();
  Map<String, dynamic>? intentPaymentData;
  var logger = Logger();

  Future<void> showPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      intentPaymentData = null;
      logger.i("Pago exitoso");
      final paymentIntentId = controller.transaction.value.paymentIntentId;
      await fetchPaymentDetails(paymentIntentId);
      logger.i("Charge ID obtenido.");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TransferenciaEsperaScreen()),
      );
    } on StripeException catch (error) {
      logger.e("Error de Stripe: $error");
      showDialog(
        context: context,
        builder: (c) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: const Text("Pago cancelado"),
          content: const Text("El pago fue cancelado por el usuario."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        ),
      );
    } catch (error) {
      logger.e("Error al procesar el pago: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Hubo un error al procesar el pago"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<Map<String, dynamic>?> makeIntentForPayment(String amountToBeCharge, String currency) async {
    try {
      Map<String, dynamic> paymentInfo = {
        "amount": (int.parse(amountToBeCharge) * 100).toString(),
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
        controller.setPaymentId(responseData["id"]);
      }

      return responseData;
    } catch (errorMsg) {
      logger.e("Error en la solicitud de pago: $errorMsg");
      return null;
    }
  }

  Future<void> paymentSheetInitialization(BuildContext context, String amountToBeCharge, String currency) async {
    try {
      intentPaymentData = await makeIntentForPayment(amountToBeCharge, currency);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: intentPaymentData!["client_secret"],
          style: ThemeMode.light,
          merchantDisplayName: "Keidot App",
        ),
      );
      showPaymentSheet(context);
    } catch (errorMsg, s) {
      logger.e("Error en la inicialización del pago: $errorMsg", error: errorMsg, stackTrace: s);
    }
  }

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
        controller.setChargeId(responseData["latest_charge"]);
      }
    } catch (error) {
      logger.e("Error obteniendo detalles del pago: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactionController = Get.find<ServiceTransactionController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Pago Seguro con Stripe",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() {
              final amount = transactionController.transaction.value.amount ?? 0.0;
              return ElevatedButton(
                onPressed: () {
                  paymentSheetInitialization(context, amount.round().toString(), "MXN");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  'Pagar ahora \$${amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            const Icon(
              Icons.lock_outline,
              color: Colors.green,
              size: 40,
            ),
            const Text(
              "Tu pago es 100% seguro y encriptado.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
