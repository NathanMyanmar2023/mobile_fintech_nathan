import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HMSRowView extends StatelessWidget {
  final String hour;
  final String min;
  final String sec;
  const HMSRowView({Key? key, required this.hour, required this.min, required this.sec}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
          child: Text(
            hour,
            style: const TextStyle(
                fontSize: 18.0,
                color: colorPrimary,
                fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            ":",
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w800),
          ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
          child: Text(
            min,
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Text(
            ":",
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w800),
          ),
        ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
          child: Text(
            sec,
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
