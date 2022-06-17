import 'package:bits_and_sats_frontend/components/circular_progress.dart';
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _weblnMethods.checkWebln(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data != null) {
            return const MainMenuScreen();
          } else {
            return const NoWalletScreen();
          }
        } else {
          return const Center(
            child: CircularProgress(),
          );
        }
      },
    );
  }
}
