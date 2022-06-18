import 'package:flutter/material.dart';
import 'dart:js' as js;

class PaymentResultScreen extends StatefulWidget {
  const PaymentResultScreen({Key? key}) : super(key: key);

  @override
  State<PaymentResultScreen> createState() => _PaymentResultScreenState();
}

class _PaymentResultScreenState extends State<PaymentResultScreen> {
  late var res;

  @override
  void initState() {
    res = js.JsObject.fromBrowserObject(js.context['paymentState']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Preimage is ${res["preimage"]}"),
            Text("Payment Hash is ${res["paymentHash"]}"),
          ],
        )),
      ),
    );
  }
}
