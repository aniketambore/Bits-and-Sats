import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../provider/room_data_provider.dart';
import '../utils/colors.dart';
import '../utils/responsive.dart';
import '../widgets/contra_text.dart';
import '../widgets/custom_textfield.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({Key? key}) : super(key: key);

  @override
  State<WaitingLobby> createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  late TextEditingController roomIdController;

  @override
  void initState() {
    roomIdController = TextEditingController(
      text:
          Provider.of<RoomDataProvider>(context, listen: false).roomData["_id"],
    );
    super.initState();
  }

  @override
  void dispose() {
    roomIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          color: lighteningYellow,
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(
                child: SvgPicture.asset(
                  "assets/icons/bitcoin.svg",
                  width: 370,
                  height: 590,
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Flexible(
                child: SvgPicture.asset(
                  "assets/icons/lightning.svg",
                  width: 370,
                  height: 590,
                ),
              ),
            ],
          ),
        ),
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
                      text: "Waiting Lobby",
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Waiting for a player to join...",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          color: trout,
                          fontWeight: FontWeight.w500),
                    ),
                    // SizedBox(
                    //   height: 12,
                    // ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextField(
                      controller: roomIdController,
                      labelText: "",
                      hintText: "",
                      isReadOnly: true,
                      icon: Icons.keyboard_command_key_sharp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
