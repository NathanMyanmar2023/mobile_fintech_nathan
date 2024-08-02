import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fnge/resources/colors.dart';

class TextFieldView extends StatelessWidget {
  final TextEditingController controller;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextStyle? textStyle;
  final bool isPassword;
  final TextInputType keyboardType;
  final IconData? icon;
  final String? hintText;
  final double? radius;
  final List<TextInputFormatter>? inputFormatters;

  const TextFieldView({
    super.key,
    this.crossAxisAlignment,
    this.textStyle,
    required this.controller,
    this.isPassword = false,
    this.radius = 100.0,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.hintText = "",
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon == null
            ? null
            : Icon(
                icon,
                color: colorPrimary,
              ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius!),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
      ),
    );
  }
}
