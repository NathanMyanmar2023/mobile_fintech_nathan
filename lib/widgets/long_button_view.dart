import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';

class LongButtonView extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final Function onTap;
  final double width;
  final BorderRadiusGeometry? borderRadius;

  const LongButtonView({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.backgroundColor,
    this.borderRadius,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor ?? colorPrimary,
          borderRadius: borderRadius ?? BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: textColor ?? colorWhite,
            ),
          ),
        ),
      ),
    );
  }
}


class textButtonView extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final Function onTap;
  final double width;
  final double size;
  final BorderRadiusGeometry? borderRadius;

  const textButtonView({
    super.key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.backgroundColor,
    this.borderRadius,
    this.size = 15,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: width,
          padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: backgroundColor ?? colorPrimary,
          borderRadius: borderRadius ?? BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w700,
              color: textColor ?? colorWhite,
            ),
          ),
        ),
      ),
    );
  }
}
class LongInfoView extends StatelessWidget {
  final String titleText;
  final String msgText;
  final Color? textColor;
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final bool showIcon;

  const LongInfoView({
    super.key,
    required this.titleText,
    required this.msgText,
    this.textColor,
    this.backgroundColor,
    this.borderRadius,
    this.showIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      // decoration: BoxDecoration(
      //   color: backgroundColor ?? colorPrimary,
      //   borderRadius: borderRadius ?? BorderRadius.circular(100),
      // ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titleText,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
             // color: colorSeconary,
            ),
          ),
          Row(
            children: [
              showIcon ? const Padding(
                padding:  EdgeInsets.only(right: 8),
                child:  Icon(Icons.wallet, color: colorPrimary,),
              ) : const SizedBox(),
              Text(
                msgText,
                style:const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: colorBlack,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
