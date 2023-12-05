import 'package:flutter/material.dart';

class SizeConfig {
  // ignore: unused_field
  static MediaQueryData? _mediaQueryData;

  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData?.size.width ?? 0;
    screenHeight = _mediaQueryData?.size.height ?? 0;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
  }
}
