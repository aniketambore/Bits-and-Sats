import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ButtonPlainWithIcon extends StatelessWidget {
  final String text;
  final IconData iconPath;
  final VoidCallback callback;
  final bool isPrefix;
  final bool isSuffix;
  final Color color;
  final Color textColor;
  final double? size;

  const ButtonPlainWithIcon(
      {Key? key,
      required this.text,
      required this.callback,
      required this.isPrefix,
      required this.isSuffix,
      required this.iconPath,
      required this.color,
      this.size,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: size != null ? size! : MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          primary: color,
          textStyle: TextStyle(color: textColor),
        ),
        onPressed: callback,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            isPrefix
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      iconPath,
                      color: white,
                    ),
                  )
                : const SizedBox(),
            Text(
              text,
              style:
                  const TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
            ),
            isSuffix
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(iconPath),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
