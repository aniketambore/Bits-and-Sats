import 'package:bits_and_sats_frontend/utils/colors.dart';
import 'package:bits_and_sats_frontend/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../widgets/button_plain_with_icon.dart';

class NoWalletScreen extends StatelessWidget {
  // static String routeName = '/no-wallet';
  const NoWalletScreen({Key? key}) : super(key: key);

  void _launchUrl() async {
    const url = "https://getalby.com/";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      child: Material(
          child: Container(
        color: white,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/no.gif",
                      fit: BoxFit.cover,
                      // height: 340,
                      // width: 310,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 12.0, bottom: 4.0),
                    child: Text(
                      "Bits and Sats",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 21,
                          color: santasGray,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                        left: 24.0, right: 24.0, top: 4.0, bottom: 12.0),
                    child: Text(
                      "No wallet found !",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 44,
                          color: woodSmoke,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 24.0, top: 28, right: 24),
                    child: ButtonPlainWithIcon(
                      color: persianBlue,
                      textColor: woodSmoke,
                      iconPath: Icons.wallet,
                      isPrefix: true,
                      isSuffix: false,
                      text: "Install Wallet",
                      callback: _launchUrl,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
