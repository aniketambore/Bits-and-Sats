import 'package:bits_and_sats_frontend/utils/colors.dart';
import 'package:bits_and_sats_frontend/utils/responsive.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      child: Material(
        child: Container(
          color: white,
          child: Center(
            child: Image.network(
              "https://i.imgur.com/mO9M80w.gif",
              fit: BoxFit.cover,
              // height: 340,
              // width: 310,
            ),
          ),
        ),
      ),
    );
  }
}
