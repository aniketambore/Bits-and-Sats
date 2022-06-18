import 'package:bits_and_sats_frontend/utils/colors.dart';
import 'package:bits_and_sats_frontend/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/room_data_provider.dart';

class Scoreboard extends StatelessWidget {
  const Scoreboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    String splitToNickname(String walletAddress) {
      var nickname = walletAddress.split("@");
      return nickname[0];
    }

    return Responsive(
      child: Container(
        margin: const EdgeInsets.only(left: 18, right: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: persianBlue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    // roomDataProvider.player1.nickname,
                    splitToNickname(roomDataProvider.player1.nickname),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: white),
                  ),
                  Text(
                    roomDataProvider.player1.points.toInt().toString(),
                    style: const TextStyle(fontSize: 20, color: white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    // roomDataProvider.player2.nickname,
                    splitToNickname(roomDataProvider.player2.nickname),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: white),
                  ),
                  Text(
                    roomDataProvider.player2.points.toInt().toString(),
                    style: const TextStyle(fontSize: 20, color: white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
