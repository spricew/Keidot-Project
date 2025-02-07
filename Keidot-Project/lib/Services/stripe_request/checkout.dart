import 'package:flutter/material.dart';
import 'package:test_app/Services/stripe_request/stripe_service.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Stripe Checkout",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            var items = [
              {"productPrice": 4, "productName": "Apple", "qty": 5},
              {"productPrice": 5, "productName": "PineApple", "qty": 15},
            ];
            await StripeService.StripePaymentCheckout(
              items,
              500,
              context,
              onSuccess: () {
                print("Pago exitoso.");
              },
              onCancel: () {
                print("Pago cancelado.");
              },
              onError: (e) {
                print("Error en el pago: $e");
              },
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(1)),
            ),
          ),
          child: const Text("Checkout"),
        ),
      ),
    );
  }
}
