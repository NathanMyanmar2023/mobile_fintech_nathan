import 'package:flutter/material.dart';
import 'package:flutter_mdetect/flutter_mdetect.dart';
import 'package:rabbit_converter/rabbit_converter.dart';

class ThemeText{
  ThemeText._();

  static const defaultColor = Colors.red;

  static String mmText(String text) {
    String unicodeText = Rabbit.zg2uni(text);
    String zawgyiText = Rabbit.uni2zg(unicodeText);
    return Rabbit.uni2zg(text);
    // return MDetect.isUnicode() ? text : Rabbit.uni2zg(text);
  }
}