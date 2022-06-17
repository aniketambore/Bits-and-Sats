import 'package:bits_and_sats_frontend/screens/main_menu_screen.dart';
import 'package:flutter/material.dart';
import '../services/webln_methods.dart';
import 'nowallet_screen.dart';

class LandingScreen extends StatefulWidget {
  static String routeName = '/landing-screen';
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final WeblnMethods _weblnMethods = WeblnMethods();
  late bool _isWebln;

  @override
  void initState() {
    _isWebln = _weblnMethods.checkWebln();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isWebln) {
      return MainMenuScreen();
    }
    return NoWalletScreen();
    // return FutureBuilder(
    //   future: _weblnMethods.checkWebln(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       if (snapshot.data != null) {
    //         return const MainMenuScreen();
    //       } else {
    //         return const NoWalletScreen();
    //       }
    //     } else {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     }
    //   },
    // );
  }
}
