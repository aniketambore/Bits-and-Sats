import 'dart:convert';
import 'package:bits_and_sats_frontend/models/create_invoice.dart';
import 'package:http/http.dart';
import '../models/wallet.dart';

class LNBitsApi {
  final String _apiKey = "c0a6112944fd43eaa554c20f6760f4b4";

  Future<Wallet> getWalletDetails() async {
    return _getWalletDetails();
  }

  Future<CreateInvoice> createInvoiceResult() async {
    return _createInvoice();
  }

  Future<Map<String, dynamic>> checkPaidInvoice(String paymentHash) async {
    return _checkPaidInvoice(paymentHash);
  }

  Future<Wallet> _getWalletDetails() async {
    final Response response = await get(
      Uri.parse("https://legend.lnbits.com/api/v1/wallet"),
      // Send authorization headers to the backend.
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "X-Api-Key": _apiKey,
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return Wallet.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load wallet details');
    }
  }

  Future<CreateInvoice> _createInvoice() async {
    final Response response = await post(
      Uri.parse("https://legend.lnbits.com/api/v1/payments"),
      // Send authorization headers to the backend.
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "X-Api-Key": _apiKey,
      },
      body: jsonEncode(
        {"out": false, "amount": 3, "memo": "Bits and Sats", "unit": "sat"},
      ),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response, then parse the JSON.
      print(
          "[+] _createInvoice | lnbits_api.dart | invoice result is ${response.body}");
      return CreateInvoice.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response, then throw an exception.
      throw Exception('Failed to create invoice.');
    }
  }

  Future<Map<String, dynamic>> _checkPaidInvoice(String paymentHash) async {
    final Response response = await get(
      Uri.parse("https://legend.lnbits.com/api/v1/payments/$paymentHash"),
      // Send authorization headers to the backend.
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
        "X-Api-Key": _apiKey,
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return jsonDecode(response.body);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to check paid invoice');
    }
  }
}
