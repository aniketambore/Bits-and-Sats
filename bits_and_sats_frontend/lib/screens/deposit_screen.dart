import 'package:bits_and_sats_frontend/screens/create_room_screen.dart';
import 'package:flutter/material.dart';

import '../services/webln_methods.dart';
import '../utils/colors.dart';
import '../utils/responsive.dart';
import '../widgets/contra_text.dart';
import '../widgets/custom_image.dart';
import '../widgets/pay_invoice_button.dart';
import 'join_room_screen.dart';

class DepositSatsScreen extends StatefulWidget {
  static String routeName = '/deposit-screen';
  const DepositSatsScreen({Key? key}) : super(key: key);

  @override
  State<DepositSatsScreen> createState() => _DepositSatsScreenState();
}

class _DepositSatsScreenState extends State<DepositSatsScreen> {
  final WeblnMethods _weblnMethods = WeblnMethods();

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoomScreen.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
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
                        children: const [
                          ContraText(
                            text: "Deposit 10 Sats",
                            alignment: Alignment.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Play your faviorite game Tic-Tac-Toe with your friend for sats!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 17,
                                color: trout,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          PayInvoiceButton(
                            bgColor: woodSmoke,
                            textValue: "Deposit",
                            iconData: Icons.room_preferences_outlined,
                            sendPayment: sendPayment,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }

  void sendPayment(String invoice) async {
    _weblnMethods.sendPayment(invoice);

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    if (arguments["toRoute"] == "createRoom") {
      createRoom(context);
    } else if (arguments["toRoute"] == "joinRoom") {
      joinRoom(context);
    }
  }
}
