import 'package:flutter/material.dart';

class FZColors {
  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";

  static const int primaryValue = 0xFF24292E;
  static const int primaryLightValue = 0xFF42464b;
  static const int primaryDarkValue = 0xFF121917;

  static const int white = 0xffffffff;

  static const int colorPri = 0xff00c3a7;

  // text colors
  static const whiteText = Color(white);

  static const MaterialColor primarySwatch = const MaterialColor(
    primaryValue,
    const <int, Color>{
      50: const Color(primaryValue),
      100: const Color(primaryValue),
      200: const Color(primaryValue),
      300: const Color(primaryValue),
      400: const Color(primaryValue),
      500: const Color(primaryValue),
      600: const Color(primaryValue),
      700: const Color(primaryValue),
      800: const Color(primaryValue),
      900: const Color(primaryValue),
    },
  );
}
