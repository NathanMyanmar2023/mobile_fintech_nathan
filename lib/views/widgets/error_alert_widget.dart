import 'package:flutter/material.dart';

class ErrorAlert extends StatelessWidget {
  // ignore: non_constant_identifier_names
  Image error_icon;
  String error_title;
  String error_message;
  ErrorAlert(this.error_title, this.error_icon, this.error_message,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: AlertDialog(
        title: Text(error_title),
        content: SizedBox(
          height: 150,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: error_icon,
                ),
              ),
              Text(
                error_message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('Ok'.toUpperCase()),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
