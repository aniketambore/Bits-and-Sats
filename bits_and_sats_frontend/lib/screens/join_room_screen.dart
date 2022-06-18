import 'package:bits_and_sats_frontend/widgets/pay_invoice_button.dart';
import 'package:flutter/material.dart';
import '../api/lnbits_api.dart';
import '../services/webln_methods.dart';
import '../utils/colors.dart';
import '../utils/responsive.dart';
import '../widgets/button_plain_with_icon.dart';
import '../widgets/contra_text.dart';
import '../widgets/custom_image.dart';
import '../widgets/custom_textfield.dart';
import '../services/socket_methods.dart';
import 'dart:js' as js;

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _gameIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();
  final LNBitsApi _lnBitsApi = LNBitsApi();
  bool invoicePaid = false;

  @override
  void initState() {
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayersStateListener(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _gameIdController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        color: lighteningYellow,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const CustomImage(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                assetPath: "assets/icons/bitcoin.svg"),
            const CustomImage(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                assetPath: "assets/icons/lightning.svg"),
            Responsive(
              child: Container(
                height: 410,
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), color: white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: [
                        const ContraText(
                          text: "Join Room",
                          alignment: Alignment.center,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Play your faviorite game Tic-Tac-Toe with your friend for sats!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 17,
                              color: trout,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        invoicePaid
                            ? Container()
                            : const Text(
                                "It looks like you've not deposited the sats or else please click the create button again.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: flamingo,
                                    fontWeight: FontWeight.w500),
                              ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          labelText: "Wallet Adderss",
                          hintText: "aniketambore@getalby.com",
                          icon: Icons.person,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          controller: _gameIdController,
                          labelText: "Game ID",
                          hintText: 'Enter your Game ID',
                          icon: Icons.indeterminate_check_box_outlined,
                        ),
                        SizedBox(height: size.height * 0.045),
                        ButtonPlainWithIcon(
                          color: persianBlue,
                          textColor: white,
                          iconPath: Icons.meeting_room_sharp,
                          isPrefix: true,
                          isSuffix: false,
                          text: "Join",
                          // callback: () => _socketMethods.joinRoom(
                          //     _nameController.text, _gameIdController.text),
                          callback: checkPaidInvoice,
                        ),
                        // PayInvoiceButton(
                        //     bgColor: persianBlue,
                        //     textValue: "Join",
                        //     iconData: Icons.meeting_room_sharp,
                        //     sendPayment: sendPayment)
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkPaidInvoice() {
    var paymentResult =
        js.JsObject.fromBrowserObject(js.context['paymentState']);
    var checkInvoice =
        _lnBitsApi.checkPaidInvoice(paymentResult["paymentHash"]);
    checkInvoice.then((value) {
      print(
          "[+] _sendPayment | webln_methods.dart | checkInvoiceResult is $value");
      if (value["paid"] == true) {
        setState(() {
          invoicePaid = true;
        });
        _socketMethods.joinRoom(_nameController.text, _gameIdController.text);
      } else {
        invoicePaid = false;
      }
    });
  }

  // void sendPayment(String invoice) async {
  //   if (_nameController.text.isNotEmpty && _gameIdController.text.isNotEmpty) {
  //     // _weblnMethods.sendPaymentMethod(context,
  //     //     invoice: invoice, checkPaidInvoice: checkPaidInvoice);
  //   }
  // }

  // void checkPaidInvoice(String paymentHash) {
  //   // Future<Map<String, dynamic>> checkInvoice = _lnBitsApi.checkPaidInvoice(weblnProvier.paymentResponseResult.paymentHash!);
  //   var checkInvoice = _lnBitsApi.checkPaidInvoice(paymentHash);
  //   checkInvoice.then((value) {
  //     print(
  //         "[+] _sendPayment | webln_methods.dart | checkInvoiceResult is $value");
  //     if (value["paid"] == true) {
  //       _socketMethods.joinRoom(_nameController.text, _gameIdController.text);
  //     }
  //   });
  // }
}
