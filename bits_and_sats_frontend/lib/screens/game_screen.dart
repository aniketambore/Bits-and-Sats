import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/room_data_provider.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game-screen';
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Provider.of<RoomDataProvider>(context).roomData.toString()),
      ),
    );
  }
}
