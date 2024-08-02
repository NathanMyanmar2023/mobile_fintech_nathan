import 'package:flutter/material.dart';
import 'package:fnge/resources/colors.dart';

class OrderInfoView extends StatelessWidget {
  final String infoTitle;
  final String infoMsg;
  const OrderInfoView(
      {Key? key, required this.infoTitle, required this.infoMsg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          infoTitle,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          infoMsg,
          style: const TextStyle(
            color: colorBlack,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
