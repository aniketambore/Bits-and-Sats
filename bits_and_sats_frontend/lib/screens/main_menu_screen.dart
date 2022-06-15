import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../widgets/button_plain_with_icon.dart';
import '../widgets/contra_text.dart';
import 'create_room_screen.dart';
import 'join_room_screen.dart';
import '../utils/colors.dart';
import '../widgets/custom_image.dart';

class MainMenuScreen extends StatelessWidget {
  // static String routeName = '/main-menu';
  const MainMenuScreen({Key? key}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          text: "Bits and Sats",
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
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ButtonPlainWithIcon(
                          color: woodSmoke,
                          textColor: white,
                          iconPath: Icons.room_preferences_outlined,
                          isPrefix: true,
                          isSuffix: false,
                          text: "Create Room",
                          callback: () => createRoom(context),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ButtonPlainWithIcon(
                          color: persianBlue,
                          textColor: white,
                          iconPath: Icons.meeting_room_sharp,
                          isPrefix: true,
                          isSuffix: false,
                          text: "Join Room",
                          callback: () => joinRoom(context),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ButtonPlainWithIcon(
                          color: carribeanGreen,
                          textColor: white,
                          iconPath: Icons.integration_instructions,
                          isPrefix: true,
                          isSuffix: false,
                          text: "Instruction",
                          callback: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
