import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  void showSnack(String msg, Color msgColor, Color bgColor, IconData icon) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              msg,
              style: TextStyle(
                color: msgColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: const StadiumBorder(),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      backgroundColor: bgColor,
      elevation: 0,
    ));
  }
}
