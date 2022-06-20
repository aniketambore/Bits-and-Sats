@JS()
library webln_connection;

import 'dart:convert';
import 'package:js/js.dart';

// A reference to window.webln;
@JS()
external get webln;

@JS("webln.enable")
external enable();

@JS()
external sendPaymentFunction(String invoice);

@JS("JSON.stringify")
external String stringify(Object obj);

class WeblnMethods {
  Future<Map<String, dynamic>> checkWebln() async {
    final checkWebln = await _checkWebln();
    return checkWebln;
  }

  Future<Map<String, dynamic>> _checkWebln() async {
    // Below code throws error on production, works fine with localhost
    // await webln.enable();
    final weblnValue = await webln;
    // print("[+] _checkWebln | webln_methods.dart | weblnValue is ${stringify(weblnValue)}");
    final Map<String, dynamic> json = jsonDecode(stringify(weblnValue));
    if (json.isNotEmpty) {
      await enable();
      return json;
    } else {
      return {};
    }
  }

  void sendPayment(String invoice) {
    sendPaymentFunction(invoice);
  }
}
