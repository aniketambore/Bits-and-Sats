import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomImage extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final String assetPath;
  const CustomImage(
      {Key? key,
      required this.mainAxisAlignment,
      required this.crossAxisAlignment,
      required this.assetPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: lighteningYellow,
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: <Widget>[
          Flexible(
            child: SvgPicture.asset(
              assetPath,
              width: 370,
              height: 590,
            ),
          ),
        ],
      ),
    );
  }
}
