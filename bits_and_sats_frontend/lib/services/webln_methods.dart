@JS()
library webln_connection;

import 'dart:convert';

import 'package:bits_and_sats_frontend/models/payment_response.dart';
import 'package:bits_and_sats_frontend/provider/webln_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'dart:js' as js;
import 'package:js/js.dart';

import 'dart:js' as js;

// A reference to window.webln;
@JS()
external get webln;

@JS("webln.enable")
external enable();

// @JS("webln.sendPayment")
// external sendPayment(String invoice);

@JS()
external sendPaymentFunction(String invoice);

@JS("JSON.stringify")
external String stringify(Object obj);

class WeblnMethods {
  Future<Map<String, dynamic>> checkWebln() async {
    final checkWebln = await _checkWebln();
    return checkWebln;
  }

  // app.js code
  // bool checkWebln() {
  //   final checkWebln = _checkWebln();
  //   return checkWebln;
  // }

  // void sendPaymentMethod(BuildContext context,
  //     {required String invoice,
  //     required void Function(String paymentHash) checkPaidInvoice}) async {
  //   return _sendPaymentMethod(context,
  //       invoice: invoice, checkPaidInvoice: checkPaidInvoice);
  // }

  Future<Map<String, dynamic>> _checkWebln() async {
    // Below code throws error on production, works fine with localhost
    // await webln.enable();
    final weblnValue = await webln;
    print(
        "[+] _checkWebln | webln_methods.dart | weblnValue is ${stringify(weblnValue)}");
    final Map<String, dynamic> json = jsonDecode(stringify(weblnValue));
    if (json.isNotEmpty) {
      await enable();
      return json;
    } else {
      return {};
    }
  }

  // app.js code
  // bool _checkWebln() {
  //   // app.js call
  //   js.context.callMethod("checkWebln", []);
  //   var state = js.JsObject.fromBrowserObject(js.context['state']);
  //   return state["isWebln"];
  // }

  // void _sendPaymentMethod(BuildContext context,
  //     {required String invoice,
  //     required void Function(String paymentHash) checkPaidInvoice}) async {
  //   // await webln.enable();
  //   // var sendPaymentResult = await sendPayment(invoice);
  //   await sendPayment(invoice).then((value) async {
  //     final Map<String, dynamic> json = jsonDecode(stringify(value));
  //     print(
  //         "[+] _sendPayment | webln_methods.dart | sendPaymentResult is $json");
  //     WeblnProvider weblnProvier =
  //         Provider.of<WeblnProvider>(context, listen: false);
  //     weblnProvier.updatePaymentResponseResult(PaymentResponse.fromMap(json));
  //     checkPaidInvoice(weblnProvier.paymentResponseResult.paymentHash!);
  //   });
  // }

  void sendPayment(String invoice) {
    sendPaymentFunction(invoice);
  }
}
