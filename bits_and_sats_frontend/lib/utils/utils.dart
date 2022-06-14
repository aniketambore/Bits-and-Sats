import 'package:flutter/material.dart';
import '../services/game_methods.dart';
import '../screens/main_menu_screen.dart';

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
                          builder: (context) => const MainMenuScreen()),
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
