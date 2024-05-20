import 'package:flutter/material.dart';
import '../resources/colors.dart';

class CircleLoadingWidget extends StatelessWidget {
  const CircleLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Center(
          child: CircularProgressIndicator(
            backgroundColor: colorWhite,
            strokeWidth: 2,
          )
      ),
      height: 30.0,
      width: 30.0,
    );
  }
}
