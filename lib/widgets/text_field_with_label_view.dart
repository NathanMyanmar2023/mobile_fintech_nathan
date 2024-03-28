import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nathan_app/resources/colors.dart';

class TextFieldWithLabelView extends StatelessWidget {
  final TextEditingController controller;
  final CrossAxisAlignment? crossAxisAlignment;
  final TextStyle? textStyle;
  final String label;
  final bool isPassword;
  final TextInputType keyboardType;
  final IconData? icon;
  final String? hintText;
  final bool showWidget;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? viewWidget;

  const TextFieldWithLabelView({
    super.key,
    required this.label,
    this.crossAxisAlignment,
    this.textStyle,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.hintText = "",
    this.inputFormatters,
    this.showWidget = false,
    this.viewWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: textStyle ??
              const TextStyle(
                color: colorPrimary,
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          obscureText: isPassword,
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: icon == null
                ? null
                : showWidget ? viewWidget : Icon(
                    icon,
                    color: colorPrimary,
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          ),
        ),
      ],
    );
  }
}
