import 'package:flutter/material.dart';

class AppColor {
  static const Map<int, Color> primary = {
    10: Color.fromRGBO(221, 219, 240, 1),
    20: Color.fromRGBO(186, 184, 224, 1),
    30: Color.fromRGBO(152, 148, 209, 1),
    40: Color.fromRGBO(118, 112, 194, 1),
    50: Color.fromRGBO(83, 77, 179, 1),
    60: Color.fromRGBO(67, 61, 143, 1),
    70: Color.fromRGBO(50, 46, 107, 1),
    80: Color.fromRGBO(33, 31, 71, 1),
    90: Color.fromRGBO(17, 15, 36, 1),
    100: Color.fromRGBO(8, 8, 18, 1),
  };

  static const Map<int, Color> secondary = {
    10: Color.fromRGBO(212, 247, 247, 1),
    20: Color.fromRGBO(168, 240, 240, 1),
    30: Color.fromRGBO(125, 232, 232, 1),
    40: Color.fromRGBO(82, 224, 224, 1),
    50: Color.fromRGBO(38, 217, 217, 1),
    60: Color.fromRGBO(31, 173, 173, 1),
    70: Color.fromRGBO(23, 130, 130, 1),
    80: Color.fromRGBO(15, 87, 87, 1),
    90: Color.fromRGBO(8, 43, 43, 1),
    100: Color.fromRGBO(4, 22, 22, 1),
  };

  static const Color text = Color.fromRGBO(241, 241, 241, 1);
  static const Color textDim = Color.fromRGBO(213, 213, 213, 1);
  static const Color textInverted = Color.fromRGBO(15, 15, 15, 1);
  static const Color textInvertedDim = Color.fromRGBO(51, 51, 51, 1);
  static const Color bg = Color.fromRGBO(28, 27, 41, 1);

  static const Color error = Color.fromRGBO(225, 0, 60, 1);
  static const Color warning = Color.fromRGBO(236, 142, 0, 1);
  static const Color success = Color.fromRGBO(0, 225, 115, 1);
}

class AppSpacing {
  static const double xs = 4;
  static const double s = 8;
  static const double m = 16;
  static const double l = 36;
}

class AppFontSize {
  static const double h5 = 16;
  static const double h4 = 24;
  static const double h3 = 28;
  static const double h2 = 32;
  static const double h1 = 48;
}

class AppFontWeight {
  static const FontWeight normal = FontWeight.normal;
  static const FontWeight semibold = FontWeight.w400;
  static const FontWeight bold = FontWeight.bold;
}
