import 'package:flutter/material.dart';

class FZColors {
  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";

  static const int primaryValue = 0xFF040404;
  static const int primaryLightValue = 0xFF00ff00;
  static const int primaryDarkValue = 0xFFff00ff;

  static const int white = 0xffffffff;

  static const int colorPri = 0xFF040404;

  static const int textGray = 0xFF969696;

  static const int cellBlackBg = 0xFF201F1D;

  static const int lineBlack = 0xFF060405;

  static const int appBarColor = 0xFF040404;

  // text colors
  static const whiteText = Color(white);

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryLightValue),
      100: const Color(primaryLightValue),
      200: const Color(primaryLightValue),
      300: const Color(primaryLightValue),
      400: const Color(primaryLightValue),
      500: const Color(appBarColor),
      600: const Color(primaryDarkValue),
      700: const Color(primaryDarkValue),
      800: const Color(primaryDarkValue),
      900: const Color(primaryDarkValue),
    },
  );

  static const scaffoldBackgroundColor = Color(0xFF060405);

  static ThemeData themeData = new ThemeData(
    primarySwatch: primarySwatch,
    scaffoldBackgroundColor: Color(FZColors.lineBlack),
    backgroundColor: Color(FZColors.cellBlackBg),
    cardColor: Color(FZColors.cellBlackBg),
    ///progress 用到这个颜色
    accentColor: Color(FZColors.white),
    /// 设置页面等按钮背景色
    buttonColor: Color(FZColors.lineBlack),
    textTheme: TextTheme(
        /// 默认字体颜色
        body1: TextStyle(color: Color(textGray)),
        ///未知
        body2: TextStyle(color: Colors.amber),
        ///按钮文字颜色
        button: TextStyle(color: Color(white))),
//    canvasColor: Color(FZColors.cellBlackBg)
  );

  static const PROGRESS_COLOR = 0xFF201F1D;
}
