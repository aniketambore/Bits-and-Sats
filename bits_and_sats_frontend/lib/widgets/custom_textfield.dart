import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;
  final IconData icon;
  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.isReadOnly = false,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: isReadOnly,
      controller: controller,
      style: const TextStyle(
          fontSize: 21, fontWeight: FontWeight.w500, color: woodSmoke),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
            fontSize: 21, fontWeight: FontWeight.w500, color: woodSmoke),
        contentPadding: const EdgeInsets.all(16),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: black),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: black),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: black),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        border: const OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: black),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Icon(
            icon,
            size: 24,
          ),
        ),
      ),
    );
  }
}
