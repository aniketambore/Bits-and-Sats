import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/room_data_provider.dart';
import '../services/socket_methods.dart';
import '../components/waiting_lobby.dart';
import '../components/scoreboard.dart';
import '../components/bitsandsats_board.dart';

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
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Scoreboard(),
                const BitsAndSatsBoard(),
                Text("${roomDataProvider.roomData["turn"]["nickname"]}'s turn"),
              ],
            )),
    );
  }
}
