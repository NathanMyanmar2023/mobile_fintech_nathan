import 'package:flutter/material.dart';
import 'package:nathan_app/resources/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TopUpButtonWidget extends StatefulWidget {
  final String amt_name;
  final Function() target;

  const TopUpButtonWidget({
    super.key,
    required this.amt_name,
    required this.target,
  });

  @override
  State<TopUpButtonWidget> createState() => _TopUpButtonWidgetState();
}

class _TopUpButtonWidgetState extends State<TopUpButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.27,
      height: 60,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: topColors.withOpacity(0.3),
        elevation: 0,
        padding:  EdgeInsets.zero,
        onPressed: widget.target,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.amt_name.toString(),
              textAlign: TextAlign.center,
              style:  TextStyle(
                fontSize: 16.sp,
                color: colorPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              ' Ks',
              textAlign: TextAlign.center,
              style:  TextStyle(
                fontSize: 13.sp,
                color: colorPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
