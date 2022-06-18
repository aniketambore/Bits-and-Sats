// import 'package:bits_and_sats_frontend/models/payment_response.dart';
// import 'package:flutter/material.dart';
// import 'dart:js' as js;

// import '../services/webln_methods.dart';

// class PaymentResultScreen extends StatefulWidget {
//   const PaymentResultScreen({Key? key}) : super(key: key);

//   @override
//   State<PaymentResultScreen> createState() => _PaymentResultScreenState();
// }

// class _PaymentResultScreenState extends State<PaymentResultScreen> {
//   // late var res;
//   final WeblnMethods _weblnMethods = WeblnMethods();

//   // @override
//   // void initState() {
//   //   res = js.JsObject.fromBrowserObject(js.context['paymentState']);
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [displayingResponse()],
//         ),
//       )),
//     );
//   }

//   displayingResponse() {
//     return StreamBuilder<PaymentResponse>(
//       stream: _weblnMethods.paymentResponseResult(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           if (snapshot.data != null) {
//             return Text("Snapshot data is ${snapshot.data!.paymentHash}");
//           } else {
//             return Text("Snapshot data is null maybe");
//           }
//         }
//         return CircularProgressIndicator();
//       },
//     );
//   }
// }
