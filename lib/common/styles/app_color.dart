import 'package:flutter/material.dart';

class AppColor {
  const AppColor._();

  static const _primary10 = 0xffedecf9;
  static const _primary20 = 0xffc9c5ec;
  static const _primary30 = 0xffa69ee0;
  static const _primary40 = 0xff8278d4;
  static const _primary50 = 0xff5e51c7;
  static const _primary60 = 0xff4538ae;
  static const _primary70 = 0xff352b87;
  static const _primary80 = 0xff261f61;
  static const _primary90 = 0xff17133a;
  static const _primary100 = 0xff080613;

  static const Map<int, Color> primary = {
    10: Color(_primary10),
    20: Color(_primary20),
    30: Color(_primary30),
    40: Color(_primary40),
    50: Color(_primary50),
    60: Color(_primary60),
    70: Color(_primary70),
    80: Color(_primary80),
    90: Color(_primary90),
    100: Color(_primary100),
  };

  static const _secondary10 = 0xffeafbf8;
  static const _secondary20 = 0xffbff2ea;
  static const _secondary30 = 0xff95eadc;
  static const _secondary40 = 0xff6ae1cd;
  static const _secondary50 = 0xff40d9bf;
  static const _secondary60 = 0xff26bfa6;
  static const _secondary70 = 0xff1e9581;
  static const _secondary80 = 0xff156a5c;
  static const _secondary90 = 0xff0d4037;
  static const _secondary100 = 0xff041512;

  static const Map<int, Color> secondary = {
    10: Color(_secondary10),
    20: Color(_secondary20),
    30: Color(_secondary30),
    40: Color(_secondary40),
    50: Color(_secondary50),
    60: Color(_secondary60),
    70: Color(_secondary70),
    80: Color(_secondary80),
    90: Color(_secondary90),
    100: Color(_secondary100),
  };

  static const Color text = Color(0xfffefefe);
  static const Color textDimmed = Color(0xffeaeaea);
  static const Color textInverted = Color(0xff111111);
  static const Color textInvertedDimmed = Color(0xff333333);
  static const Color bg = Color(_primary100);

  static const Color error = Color(0xffff1a47);
  static const Color warning = Color(0xffffab1a);
  static const Color success = Color(0xff35e452);
  static const Color info = Color(_primary50);
}
