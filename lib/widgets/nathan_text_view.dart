import 'package:flutter/material.dart';

class NathanTextView extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight fontWeight;
  const NathanTextView(
      {Key? key,
      required this.text,
      this.color = Colors.black,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w500})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
