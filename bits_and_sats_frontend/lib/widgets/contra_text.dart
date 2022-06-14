import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ContraText extends StatelessWidget {
  final Alignment alignment;
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? textAlign;

  const ContraText(
      {Key? key,
      required this.alignment,
      required this.text,
      this.size,
      this.color,
      this.weight,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.start,
        style: TextStyle(
            fontSize: size ?? 36,
            fontWeight: weight ?? FontWeight.w800,
            color: color ?? black),
      ),
    );
  }
}
