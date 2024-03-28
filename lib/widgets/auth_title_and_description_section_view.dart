import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';

class AuthTitleAndDescriptionSectionView extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final String description;
  final Color? descriptionColor;
  final EdgeInsetsGeometry? margin;

  const AuthTitleAndDescriptionSectionView({
    super.key,
    required this.title,
    required this.description,
    this.titleColor,
    this.descriptionColor,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              color: titleColor ?? colorWhite,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: descriptionColor ?? colorWhite,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
