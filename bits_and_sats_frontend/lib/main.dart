import 'package:bits_and_sats_frontend/provider/webln_provider.dart';
import 'package:bits_and_sats_frontend/screens/deposit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/colors.dart';
import 'screens/join_room_screen.dart';
import 'screens/create_room_screen.dart';
import 'screens/game_screen.dart';
import 'provider/room_data_provider.dart';
import 'screens/landing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RoomDataProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeblnProvider(),
        ),
      ],
      child: MaterialApp(
        title: "Bits and Sats",
        theme: ThemeData(
            fontFamily: 'Montserrat',
            primarySwatch: Colors.indigo,
            primaryColor: persianBlue),
        routes: {
          LandingScreen.routeName: (context) => const LandingScreen(),
          DepositSatsScreen.routeName: (context) => const DepositSatsScreen(),
          // NoWalletScreen.routeName: (context) => const NoWalletScreen(),
          // MainMenuScreen.routeName: (context) => const MainMenuScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        // initialRoute: MainMenuScreen.routeName,
        initialRoute: LandingScreen.routeName,
      ),
    );
  }
}
