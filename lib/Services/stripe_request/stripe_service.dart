import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class StripeService {
  static String secretKey =
      "sk_test_51QosTy01xnYAfLDqRv4NYrlGJLwITV45DhXU97yJT6hKmKmpYUxxN9frufYRBd3VCp3o0WLTfhHsIZCoH2qnBHbm00Ll2N5bXQ";
  static String publishableKey =
      "pk_test_51QosTy01xnYAfLDqNDVaLOgDziogEwEkT9f61PyYfwsVXZe9mgU5dPmNvuj7zklxdeOIxJQKS3KkKDfMeww2adf600oaS8pkHB";

  static Future<String?> createCheckoutSession(
      List<dynamic> productItems, double totalAmount) async {
    final url = Uri.parse("https://api.stripe.com/v1/checkout/sessions");

    Map<String, String> body = {
      'success_url': 'https://checkout.stripe.dev/success',
      'cancel_url': 'https://checkout.stripe.dev/cancel',
      'mode': 'payment',
      'payment_method_types[]': 'card',
    };

    for (int i = 0; i < productItems.length; i++) {
      var product = productItems[i];
      var productPrice = (product["productPrice"] * 100).round().toString();
      body['line_items[$i][price_data][currency]'] = 'EUR';
      body['line_items[$i][price_data][unit_amount]'] = productPrice;
      body['line_items[$i][price_data][product_data][name]'] =
          product['productName'];
      body['line_items[$i][quantity]'] = product['qty'].toString();
    }

    final response = await http.post(
      url,
      body: body,
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)["id"];
    } else {
      print("Error en Stripe: ${response.body}");
      return null;
    }
  }

  static Future<void> StripePaymentCheckout(
      List<dynamic> productItems, double subTotal, BuildContext context,
      {void Function()? onSuccess,
      void Function()? onCancel,
      void Function(String)? onError}) async {
    final String? sessionId =
        await createCheckoutSession(productItems, subTotal);

    if (sessionId == null) {
      onError?.call("No se pudo crear la sesión de pago.");
      return;
    }

    try {
      await redirectToCheckout(sessionId);
      onSuccess?.call();
    } catch (e) {
      onError?.call(e.toString());
    }
  }

  static Future<void> redirectToCheckout(String sessionId) async {
    final url = "https://checkout.stripe.com/pay/$sessionId";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }
}
