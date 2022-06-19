@JS()
library lnurl_pay;

import 'dart:convert';

import 'package:js/js.dart';

@JS("JSON.stringify")
external String stringify(Object obj);

@JS("LnurlPay.requestInvoice")
external requestInvoice(RequestInvoiceOptions options);

@JS()
@anonymous
class RequestInvoiceOptions {
  external String get lnUrlOrAddress;
  external set lnUrlOrAddress(String v);

  external num get tokens;
  external set tokens(num v);

  external String get comment;
  external set comment(String v);

  external factory RequestInvoiceOptions(
      {String lnUrlOrAddress, num tokens, String comment});
}

class LnurlPay {
  void requestingInvoice(String walletAddress) async {
    try {
      var result = await requestInvoice(RequestInvoiceOptions(
          lnUrlOrAddress: walletAddress,
          tokens: 20,
          comment: "Congratulations on winning the game !"));
      result.then((invoiceResult) {
        var _invoiceResult = stringify(invoiceResult);
        print("[+] Request Invoice result is $_invoiceResult");
        _stringToJson(_invoiceResult);
      });
    } catch (e) {
      print("[!] Error in _requestingInvoice method is $e");
    }
  }

  void _stringToJson(_invoiceResult) async {
    var jsonResult = jsonDecode(_invoiceResult);
    var invoiceResult = jsonEncode(jsonResult["invoice"]);
    print("[+] Invoice result is $invoiceResult");
  }
}
