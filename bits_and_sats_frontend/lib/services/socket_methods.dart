import 'socket_client.dart';
import 'package:flutter/material.dart';
import '../screens/game_screen.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

// EMIT
  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit("createRoom", {"nickname": nickname});
    } else {
      print("[+] Nickname cannot be empty bro :(");
    }
  }

// LISTENER
  void createRoomSuccessListener(BuildContext context) {
    _socketClient.on('createRoomSuccess', (room) {
      print("[+] Created room is $room");
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }
}
