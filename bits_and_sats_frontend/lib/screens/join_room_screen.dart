import 'package:bits_and_sats_frontend/widgets/button_plain_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/colors.dart';
import '../utils/responsive.dart';
import '../widgets/contra_text.dart';
import '../widgets/custom_textfield.dart';
import '../services/socket_methods.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _gameIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListener(context);
    _socketMethods.updatePlayersStateListener(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _gameIdController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
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
                        text: "Join Room",
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
                      CustomTextField(
                        controller: _nameController,
                        hintText: 'Enter your nickname',
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _gameIdController,
                        hintText: 'Enter your Game ID',
                        icon: Icons.indeterminate_check_box_outlined,
                      ),
                      SizedBox(height: size.height * 0.045),
                      ButtonPlainWithIcon(
                        color: persianBlue,
                        textColor: white,
                        iconPath: Icons.meeting_room_sharp,
                        isPrefix: true,
                        isSuffix: false,
                        text: "Join",
                        callback: () => _socketMethods.joinRoom(
                            _nameController.text, _gameIdController.text),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

    // return Scaffold(
    //   body: Responsive(
    //     child: Container(
    //       margin: const EdgeInsets.symmetric(
    //         horizontal: 20,
    //       ),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           const CustomText(
    //             shadows: [
    //               Shadow(
    //                 blurRadius: 40,
    //                 color: Colors.blue,
    //               ),
    //             ],
    //             text: 'Join Room',
    //             fontSize: 70,
    //           ),
    //           SizedBox(height: size.height * 0.08),
    //           CustomTextField(
    //             controller: _nameController,
    //             hintText: 'Enter your nickname',
    //             icon: Icons.person,
    //           ),
    //           const SizedBox(height: 20),
    //           CustomTextField(
    //             controller: _gameIdController,
    //             hintText: 'Enter Game ID',
    //             icon: Icons.indeterminate_check_box_sharp,
    //           ),
    //           SizedBox(height: size.height * 0.045),
    //           CustomButton(
    //             onTap: () => _socketMethods.joinRoom(
    //                 _nameController.text, _gameIdController.text),
    //             text: 'Join',
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
