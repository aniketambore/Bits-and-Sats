import 'package:bits_and_sats_frontend/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../provider/room_data_provider.dart';
import '../services/socket_methods.dart';

class BitsAndSatsBoard extends StatefulWidget {
  const BitsAndSatsBoard({Key? key}) : super(key: key);

  @override
  State<BitsAndSatsBoard> createState() => _BitsAndSatsBoardState();
}

class _BitsAndSatsBoardState extends State<BitsAndSatsBoard> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    _socketMethods.tappedListener(context);
    super.initState();
  }

  void tapped(int index, RoomDataProvider roomDataProvider) {
    _socketMethods.tapGrid(
      index,
      roomDataProvider.roomData['_id'],
      roomDataProvider.displayElements,
    );
  }

  Widget buildElement(String playerElement) {
    if (playerElement == "X") {
      return SvgPicture.asset(
        "assets/icons/bitcoin.svg",
        fit: BoxFit.cover,
      );
    } else if (playerElement == "O") {
      return SvgPicture.asset(
        "assets/icons/lightning.svg",
        fit: BoxFit.cover,
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: AbsorbPointer(
        absorbing: roomDataProvider.roomData["turn"]["socketID"] !=
            _socketMethods.socketClient.id,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => tapped(index, roomDataProvider),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: carribeanGreen),
                ),
                child: Center(
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 200),
                      child:
                          buildElement(roomDataProvider.displayElements[index]),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
