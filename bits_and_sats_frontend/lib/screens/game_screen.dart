import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/room_data_provider.dart';
import '../services/socket_methods.dart';
import '../components/waiting_lobby.dart';
import '../components/scoreboard.dart';
import '../components/bitsandsats_board.dart';
import '../utils/colors.dart';
import '../widgets/contra_text.dart';
import '../widgets/custom_image.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game-screen';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListener(context);
    _socketMethods.pointIncreaseListener(context);
    _socketMethods.endGameListener(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(Provider.of<RoomDataProvider>(context).player1.nickname);
    // print(Provider.of<RoomDataProvider>(context).player2.nickname);
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
      body: roomDataProvider.roomData["isJoin"]
          ? const WaitingLobby()
          : SafeArea(
              child: Container(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Scoreboard(),
                        Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: black.withOpacity(0.7)),
                            child: const BitsAndSatsBoard()),
                        ContraText(
                          text:
                              "${roomDataProvider.roomData["turn"]["nickname"]}'s turn",
                          size: 15,
                          alignment: Alignment.center,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
