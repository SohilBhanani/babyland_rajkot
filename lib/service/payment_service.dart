import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stripe_payment/stripe_payment.dart';

class StripeTransactionResponse {
  String message;
  bool success;

  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
//       "sk_test_51HC1eAAwfBNLaWKmRHvIRTGQZzZ7IhNAKpEvKgoqNoshiVc48m0jDoLqeMglQ1yiDVVUsesN1PeUHz4Tq9gxytBS00SKO4AJAt";

     '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';

  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  static init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey:
           "pk_live_51HC1eAAwfBNLaWKmKhkQUXCGNxEx6jXcwSltSSyZWvhzeam6Mer4kN9bFfTad4qSdcdhs3sk1e1snLKolyDGNiJR00CLpj1RLx",
//             "pk_test_51HC1eAAwfBNLaWKmy0Sg0bZoHoA0msafXfUByXarQyTKUrnodwKd7fF9srhrh4epr6ZNlpgS4tkrOFbPiLkub6i600ryjXhFsT",
        merchantId: "Test",
        androidPayMode: 'test',
      ),
    );
  }

  static Future<StripeTransactionResponse> payViaExistingCard(
      {String amount, String currency, CreditCard card}) async {
    try {
      var paymentMethod = await StripePayment.createPaymentMethod(
          PaymentMethodRequest(card: card));
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
            clientSecret: paymentIntent['client_secret'],
            paymentMethodId: paymentMethod.id),
      );
      if (response.status == 'succeeded') {
        //TODO: Firebase push details
        return StripeTransactionResponse(
          message: 'Transaction Successful',
          success: true,
        );
      } else {
        return StripeTransactionResponse(
          message: 'Transaction Failed',
          success: false,
        );
      }
    } catch (err) {
      return StripeTransactionResponse(
        message: 'Transaction failed: ${err.toString()}',
        success: false,
      );
    }
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount, String currency}) async {
    try {
      var paymentMethod = await StripePayment.paymentRequestWithCardForm(
          CardFormPaymentRequest());
      var paymentIntent =
          await StripeService.createPaymentIntent(amount, currency);
      var response = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
            clientSecret: paymentIntent['client_secret'],
            paymentMethodId: paymentMethod.id),
      );
      if (response.status == 'succeeded') {
        return StripeTransactionResponse(
          message: 'Transaction Successful',
          success: true,
        );
      } else {
        return StripeTransactionResponse(
          message: 'Transaction Failed',
          success: false,
        );
      }
    } catch (err) {
      return StripeTransactionResponse(
        message: 'Transaction failed: ${err.toString()}',
        success: false,
      );
    }
  }
//Todo: dfhodfihdfsdfsdf
  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(StripeService.paymentApiUrl,
          body: body, headers: StripeService.headers);
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user : ${err.toString()}');
    }
    return null;
  }
}
