
import 'dart:async';

import 'package:flutter/material.dart';

class TestTimerView extends StatefulWidget {
  @override
  State<TestTimerView> createState() => _TestTimerViewState();
}

class _TestTimerViewState extends State<TestTimerView> {

  late Timer _timer;
  late Duration _difference;

  @override
  void initState() {
  super.initState();
  // Calculate the time difference
  DateTime now = DateTime.now();
  DateTime targetTime = DateTime(now.year, now.month, now.day, 17, 00); // 5:14 PM today
  _difference = targetTime.difference(now);

  // Start the countdown timer
  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
  setState(() {
  if (_difference.inSeconds > 0) {
  _difference -= Duration(seconds: 1);
  } else {
  _timer.cancel();
  }
  });
  });
  }

  @override
  void dispose() {
  _timer.cancel();
  super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  // Convert remaining time to hours, minutes, and seconds
  int hours = _difference.inHours;
  int minutes = _difference.inMinutes.remainder(60);
  int seconds = _difference.inSeconds.remainder(60);

  return Scaffold(
    body: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const SizedBox(height: 100,),
    Text(
    'Time remaining until 5:14 PM:',
    ),
    Text(
    '$hours hours, $minutes minutes, $seconds seconds',
    style: Theme.of(context).textTheme.headline4,
    ),
    ],
    ),
  );
  }

}
