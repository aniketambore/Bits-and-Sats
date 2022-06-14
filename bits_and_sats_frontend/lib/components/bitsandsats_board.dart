import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/room_data_provider.dart';

class BitsAndSatsBoard extends StatefulWidget {
  const BitsAndSatsBoard({Key? key}) : super(key: key);

  @override
  State<BitsAndSatsBoard> createState() => _BitsAndSatsBoardState();
}

class _BitsAndSatsBoardState extends State<BitsAndSatsBoard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: size.height * 0.7,
        maxWidth: 500,
      ),
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white24,
              ),
            ),
            child: const Center(
              child: AnimatedSize(
                duration: Duration(milliseconds: 200),
                child: Text(
                  "X",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                      shadows: [
                        Shadow(
                          blurRadius: 40,
                          color: Colors.blue,
                        ),
                      ]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
