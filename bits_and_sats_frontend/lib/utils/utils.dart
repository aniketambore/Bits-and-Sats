import 'package:bits_and_sats_frontend/screens/landing_screen.dart';
import 'package:bits_and_sats_frontend/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import '../services/game_methods.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void showGameDialog(BuildContext context, String text, [String? methodName]) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                if (methodName != "endGame") {
                  GameMethods().clearBoard(context);
                  Navigator.pop(context);
                } else {
                  GameMethods().clearBoard(context);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LandingScreen()),
                      (route) => false);
                }
              },
              child: const Text(
                'Play Again',
              ),
            ),
          ],
        );
      });
}

void showGameDialogWinner(BuildContext context, String headlineText,
    String descText, String assetPath) {
  showDialog(
    context: context,
    builder: (_) => AssetGiffyDialog(
      image: Image.asset(
        assetPath,
        fit: BoxFit.cover,
      ),
      title: Text(
        headlineText,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
      ),
      entryAnimation: EntryAnimation.TOP_LEFT,
      description: Text(
        descText,
        textAlign: TextAlign.center,
        // style: TextStyle(),
      ),
      onlyOkButton: true,
      buttonOkColor: lighteningYellow,
      onOkButtonPressed: () {
        GameMethods().clearBoard(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LandingScreen()),
            (route) => false);
      },
    ),
  );
}
