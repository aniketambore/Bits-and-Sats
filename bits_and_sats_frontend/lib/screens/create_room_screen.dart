import 'package:flutter/material.dart';
import '../widgets/button_plain_with_icon.dart';
import '../widgets/custom_textfield.dart';
import '../utils/responsive.dart';
import '../services/socket_methods.dart';
import '../utils/colors.dart';
import '../widgets/contra_text.dart';
import '../widgets/custom_image.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = '/create-room';
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.createRoomSuccessListener(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
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
                          text: "Create Room",
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
                        SizedBox(height: size.height * 0.045),
                        ButtonPlainWithIcon(
                          color: woodSmoke,
                          textColor: white,
                          iconPath: Icons.room_preferences_outlined,
                          isPrefix: true,
                          isSuffix: false,
                          text: "Create",
                          callback: () =>
                              _socketMethods.createRoom(_nameController.text),
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
