import 'package:flutter/material.dart';

import '../resources/colors.dart';
import 'nathan_text_view.dart';

class RowIconText extends StatelessWidget {
  final IconData icon;
  final String name;
  const RowIconText({Key? key, required this.icon, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: colorPrimary, size: 18,),
          const SizedBox(width: 5,),
          NathanTextView(
            text: name,
            fontSize: 15,
          ),
        ],
      );
  }
}
