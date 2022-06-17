@JS()
library webln_connection;

import 'dart:convert';

import 'package:js/js.dart';

import 'package:bits_and_sats_frontend/models/payment_response.dart';
import 'package:bits_and_sats_frontend/provider/webln_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// A reference to window.webln;
@JS()
external get webln;

@JS("JSON.stringify")
external String stringify(Object obj);

class WeblnMethods {
  Future<Map<String, dynamic>> checkWebln() async {
    final checkWebln = await _checkWebln();
    return checkWebln;
  }

  void enablingWebln() async {
    await webln.enable();
  }

  void sendPayment(BuildContext context,
      {required String invoice,
      required void Function(String paymentHash) checkPaidInvoice}) async {
    return _sendPayment(context,
        invoice: invoice, checkPaidInvoice: checkPaidInvoice);
  }

  Future<Map<String, dynamic>> _checkWebln() async {
    //// Below code throws error on production, works fine with localhost
    // await webln.enable();
    final weblnValue = await webln;
    print(
        "[+] _checkWebln | webln_methods.dart | weblnValue is ${stringify(weblnValue)}");
    final Map<String, dynamic> json = jsonDecode(stringify(weblnValue));
    if (json.isNotEmpty) {
      return json;
    } else {
      return {};
    }
  }

  void _sendPayment(BuildContext context,
      {required String invoice,
      required void Function(String paymentHash) checkPaidInvoice}) async {
    // await webln.enable();
    var sendPaymentResult = await webln.sendPayment(invoice);
    sendPaymentResult.then((value) {
      final Map<String, dynamic> json = jsonDecode(stringify(value));
      print(
          "[+] _sendPayment | webln_methods.dart | sendPaymentResult is $json");
      WeblnProvider weblnProvier =
          Provider.of<WeblnProvider>(context, listen: false);
      weblnProvier.updatePaymentResponseResult(PaymentResponse.fromMap(json));
      checkPaidInvoice(weblnProvier.paymentResponseResult.paymentHash!);
    });
  }
}
