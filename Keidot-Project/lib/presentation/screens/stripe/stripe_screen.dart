import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/presentation/screens/stripe/keys.dart';

class HomePageStripe extends StatefulWidget {
  const HomePageStripe({super.key});

  @override
  State<HomePageStripe> createState() => _HomePageStripeState();
}

class _HomePageStripeState extends State<HomePageStripe> {
  double amount = 210;
  Map<String, dynamic>? intentPaymentData;

  showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((val) {
        intentPaymentData = null;
      }).onError((errorMsg, sTrace) {
        if (kDebugMode) {
          print(errorMsg.toString() + sTrace.toString());
        }
      });
    } on StripeException catch (error) {
      if (kDebugMode) {
        print(error);
      }
      showDialog(
          context: context,
          builder: (c) => const AlertDialog(
                content: Text("Cancelled"),
              ));
    } catch (errorMsg) {
      if (kDebugMode) {
        print(errorMsg);
      }
      print(errorMsg.toString());
    }
  }

  makeIntentForPayment(amountToBeCharge, currency) async {
    try {
      Map<String, dynamic>? paymentInfo = {
        "amount": (int.parse(amountToBeCharge)*100).toString(),
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

  paymentSheetInitialization(amountToBeCharge, currency) async {
    try {
      intentPaymentData = await makeIntentForPayment(amountToBeCharge, currency);

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  allowsDelayedPaymentMethods: true,
                  paymentIntentClientSecret:
                      intentPaymentData!["client_secret"],
                  style: ThemeMode.dark,
                  merchantDisplayName: "Keidot App"))
          .then((val) {
        print(val);
      });
      showPaymentSheet();
    } catch (errorMsg, s) {
      if (kDebugMode) {
        print(s);
      }
      print(errorMsg.toString());
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
                  amount.round().toString(),
                   "USD");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text(
                  'Pay Now ${amount.toString()}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
