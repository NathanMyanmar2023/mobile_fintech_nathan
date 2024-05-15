import 'package:flutter/material.dart';

class SuccessBackAlert extends StatelessWidget {
  // ignore: non_constant_identifier_names
  Image success_icon;
  String success_title;
  String success_message;
  SuccessBackAlert(this.success_title, this.success_icon, this.success_message,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: AlertDialog(
        title: Text(success_title),
        content: SizedBox(
          height: 150,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: success_icon,
                ),
              ),
              Text(
                success_message,
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
