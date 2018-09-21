import 'package:flutter/material.dart';
import 'package:fz/style/FZColors.dart';

class FZTextStyle {
  static const lagerTextSize = 30.0;
  static const bigTextSize = 23.0;
  static const normalTextSize = 18.0;
  static const middleTextWhiteSize = 16.0;
  static const smallTextSize = 14.0;
  static const minTextSize = 12.0;

  static var normalTextWhite = TextStyle(color: Color(FZColors.white));

  static const normalText = TextStyle(
    color: Color(FZColors.primaryValue),
    fontSize: normalTextSize,
  );
}
