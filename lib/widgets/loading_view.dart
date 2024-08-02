import 'package:flutter/material.dart';
import 'package:fnge/resources/colors.dart';

class LoadingView extends StatelessWidget {
  final bool isVisible;

  const LoadingView({
    super.key,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: colorGrey.withOpacity(0.4),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 36,
            ),
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Loading...",
                  style: TextStyle(
                    color: colorPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
