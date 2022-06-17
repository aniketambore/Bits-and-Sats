import 'package:flutter/material.dart';

import '../models/payment_response.dart';

class WeblnProvider extends ChangeNotifier {
  PaymentResponse _paymentResponseResult = PaymentResponse();

  PaymentResponse get paymentResponseResult => _paymentResponseResult;

  void updatePaymentResponseResult(PaymentResponse data) {
    _paymentResponseResult = data;
    notifyListeners();
  }
}
