import 'package:babyland_optimised/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../services/database_service.dart';
//test
//rzp_test_yyoeTOKh8VgWMN
//lHE6Jguq9xEcQ2smlGUUqvJX

//live
//rzp_live_7788YlT5Fp35zY
//MigzjNbGzvRRPacKgvB51Guw

class PaymentService with ChangeNotifier {
  var _razorpay;
  String paymentStatus = 'initial';
  List<String> names;
  String uid;
  String personName;
  String whatsapp;
  String email;
  double amount;
  String address;
  String payment;
  String status;
  BuildContext context;

  PaymentService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // PaymentSuccessResponse(paymentId, orderId, signature)
  }

  void setPaymentDetails(
    List<String> names,
    String uid,
    String personName,
    String whatsapp,
    String email,
    double amount,
    String address,
    String payment,
    String status,
    BuildContext context,
  ) {
    this.names = names;
    this.uid = uid;
    this.personName = personName;
    this.whatsapp = whatsapp;
    this.email = email;
    this.amount = amount;
    this.address = address;
    this.payment = payment;
    this.status = status;
    this.context = context;
    // notifyListeners();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Razorpay:success----------- ${response.paymentId}');
    paymentStatus = 'successful';
    // notifyListeners();

    DbService().generateOrder(
      names: names,
      uid: uid,
      personName: personName,
      whatsapp: whatsapp,
      email: email,
      amount: amount,
      address: address,
      payment: payment,
      status: status,
      orderId: response.paymentId,
      context: context,
    );

    //                         }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Razorpay:error');
    paymentStatus = 'failure';
    notifyListeners();
    Fluttertoast.showToast(
        msg: 'Payment Failed: Please Try Again Later', backgroundColor: kRed);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('Razorpay:external Wallet');
    paymentStatus = 'external_wallet';
    notifyListeners();
  }

  launchRazorPay(
      {@required String email,
      @required String contact,
      @required double amount}) {
    var options = {
      'key': 'rzp_test_yyoeTOKh8VgWMN',
      'amount': amount * 100,
      'name': 'Babyland',
      'description': ' Online Payment',
      'prefill': {'contact': contact, 'email': email},
      'external': {
        'wallets': ['paytm']
      }
    };

    _razorpay.open(options);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }
}
