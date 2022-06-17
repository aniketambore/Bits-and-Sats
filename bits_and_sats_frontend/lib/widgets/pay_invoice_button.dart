import 'package:flutter/material.dart';

import '../api/lnbits_api.dart';
import '../models/create_invoice.dart';
import '../utils/colors.dart';
import 'button_plain_with_icon.dart';

class PayInvoiceButton extends StatelessWidget {
  final Color bgColor;
  final String textValue;
  final IconData iconData;
  final void Function(String invoice) sendPayment;
  PayInvoiceButton(
      {Key? key,
      required this.bgColor,
      required this.textValue,
      required this.iconData,
      required this.sendPayment})
      : super(key: key);

  final LNBitsApi _lnBitsApi = LNBitsApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CreateInvoice>(
      future: _lnBitsApi.createInvoiceResult(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ButtonPlainWithIcon(
            color: bgColor,
            textColor: white,
            iconPath: iconData,
            isPrefix: true,
            isSuffix: false,
            text: textValue,
            callback: () => sendPayment(snapshot.data!.paymentRequest),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
