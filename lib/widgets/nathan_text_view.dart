import 'package:flutter/material.dart';

class NathanTextView extends StatelessWidget {
  final String? text;
  final Color? color;
  final double? fontSize;
  final FontWeight fontWeight;
  final bool isCenter;
  const NathanTextView(
      {Key? key,
      required this.text,
      this.color = Colors.black,
      this.fontSize = 16,
      this.fontWeight = FontWeight.w500,
        this.isCenter = false,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$text",
      textAlign: isCenter ? TextAlign.center : TextAlign.start,
      maxLines: 2,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}
