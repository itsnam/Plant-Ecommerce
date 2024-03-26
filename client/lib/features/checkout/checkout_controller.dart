import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart';

class CheckOutController {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(
      context,
      String amount,
     ) async {
    try {
      paymentIntent = await createPaymentIntent(amount);

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "USD", testEnv: true);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!["client_secret"],
              merchantDisplayName: "Plantial",
              customFlow: false,
              googlePay: gpay));
      displayPaymentSheet(context);
    } catch (e) {
      print(e.toString());
    }
  }

  void displayPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) =>
        Navigator.of(context).popUntil((route) => route.isFirst)
      );
    } catch (e) {
      print(e.toString());
    }
  }


  createPaymentIntent(amount) async {
    print(amount);
    try {
      Map<String, dynamic> body = {"amount": amount, "currency": "USD"};
      final response = await post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51OwV7mFlkKh1UFsnOcnF8CvObiW816XRksGhoCvI92t6U0GJZNSnTz9PRcHEa05JGWURgPTTIlyktS9O5psSxqsM009JGVyiof",
          });
      return json.decode(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}
