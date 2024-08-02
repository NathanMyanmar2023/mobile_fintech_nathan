import 'package:flutter/material.dart';
import 'package:fnge/resources/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainMenuButtonWidget extends StatefulWidget {
  final Icon menu_icon;
  final String menu_name;
  final Widget target_page;

  const MainMenuButtonWidget({
    super.key,
    required this.menu_icon,
    required this.menu_name,
    required this.target_page,
  });

  @override
  State<MainMenuButtonWidget> createState() => _MainMenuButtonWidgetState();
}

class _MainMenuButtonWidgetState extends State<MainMenuButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: colorPrimary,
              elevation: 0,
              padding: EdgeInsets.zero,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return widget.target_page;
                }));
              },
              child: SizedBox(
                height: 60,
                width: 60,
                child: Center(
                  child: widget.menu_icon,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.menu_name.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
