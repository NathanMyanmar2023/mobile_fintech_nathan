import 'package:flutter/material.dart';

extension NavigationExtensions on Widget {
  void popBack({required BuildContext context}) => Navigator.of(context).pop();

  void navigateToNextPage(
      {required BuildContext context, required Widget nextPage}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => nextPage),
    );
  }

  void moveToNextPage(
      {required BuildContext context, required Widget nextPage}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => nextPage),
    );
  }
}

extension NavigationExtensionsOnState on State {
  void popBack({required BuildContext context}) => Navigator.of(context).pop();

  void navigateToNextPage(
      {required BuildContext context, required Widget nextPage}) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) => nextPage),
    );
  }

  void moveToNextPage(
      {required BuildContext context, required Widget nextPage}) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => nextPage),
    );
  }
}
