import 'package:flutter/material.dart';

import '../resources/colors.dart';

class AppBarTitleView extends StatefulWidget {
  final String? text;
   AppBarTitleView({Key? key, required this.text}) : super(key: key);

  @override
  State<AppBarTitleView> createState() => _AppBarTitleViewState();
}

class _AppBarTitleViewState extends State<AppBarTitleView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: colorPrimary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "${widget.text}",
          style: const TextStyle(
            fontSize: 16,
            color: colorPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
