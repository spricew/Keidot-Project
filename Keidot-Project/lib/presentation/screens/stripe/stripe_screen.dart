import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/presentation/screens/stripe/keys.dart';
import 'package:test_app/presentation/screens/transferenciaespera_screen.dart';

class HomePageStripe extends StatefulWidget {
  const HomePageStripe({super.key});

  @override
  State<HomePageStripe> createState() => _HomePageStripeState();
}

class _HomePageStripeState extends State<HomePageStripe> {
  double amount = 210;
  Map<String, dynamic>? intentPaymentData;

  Future<void> showPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();

      // Si el pago fue exitoso, limpiar los datos y redirigir
      intentPaymentData = null;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TransferenciaEsperaScreen()),
      );
    } on StripeException catch (error) {
      print("Error de Stripe: $error");

      showDialog(
        context: context,
        builder: (c) => const AlertDialog(
          content: Text("Pago cancelado"),
        ),
      );
    } catch (error) {
      print("Error al procesar el pago: $error");

      // Mostrar mensaje de error en la UI
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Hubo un error al procesar el pago")),
      );
    }
  }

  makeIntentForPayment(amountToBeCharge, currency) async {
    try {
      Map<String, dynamic>? paymentInfo = {
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
          });
      print("response from API = ${responseFromStripeAPI.body}");

      return jsonDecode(responseFromStripeAPI.body);
    } catch (errorMsg) {
      if (kDebugMode) {
        print(errorMsg);
      }
      print(errorMsg.toString());
    }
  }

  Future<void> paymentSheetInitialization(
      BuildContext context, String amountToBeCharge, String currency) async {
    try {
      intentPaymentData =
          await makeIntentForPayment(amountToBeCharge, currency);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: intentPaymentData!["client_secret"],
          style: ThemeMode.dark,
          merchantDisplayName: "Keidot App",
        ),
      );

      showPaymentSheet(context); // Pasamos el contexto aquí
    } catch (errorMsg, s) {
      if (kDebugMode) {
        print(s);
      }
      print("Error en la inicialización del pago: $errorMsg");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                paymentSheetInitialization(
                    context, amount.round().toString(), "USD");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                'Pay Now ${amount.toString()}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
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
