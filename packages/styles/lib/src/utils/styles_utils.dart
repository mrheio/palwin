import 'package:flutter/material.dart';

Map<int, Color> _generateSwatch(int color) {
  final hsl = HSLColor.fromColor(Color(color));
  return {
    50: hsl.withLightness(0.95).toColor(),
    100: hsl.withLightness(0.9).toColor(),
    200: hsl.withLightness(0.8).toColor(),
    300: hsl.withLightness(0.7).toColor(),
    400: hsl.withLightness(0.6).toColor(),
    500: hsl.withLightness(0.5).toColor(),
    600: hsl.withLightness(0.4).toColor(),
    700: hsl.withLightness(0.3).toColor(),
    800: hsl.withLightness(0.2).toColor(),
    900: hsl.withLightness(0.1).toColor(),
  };
}

class StyleColor {
  final int _value;
  final ColorSwatch<int> _color;

  StyleColor(int color, Map<int, Color> swatch)
      : _value = color,
        _color = ColorSwatch(color, swatch);

  factory StyleColor.fromColor(int color) {
    return StyleColor(color, _generateSwatch(color));
  }

  Color get color => _color;
  Color get s50 => _color[50]!;
  Color get s100 => _color[100]!;
  Color get s200 => _color[200]!;
  Color get s300 => _color[300]!;
  Color get s400 => _color[400]!;
  Color get s500 => _color[500]!;
  Color get s600 => _color[600]!;
  Color get s700 => _color[700]!;
  Color get s800 => _color[800]!;
  Color get s900 => _color[900]!;

  Map<int, Color> toSwatch() {
    return {
      50: s50,
      100: s100,
      200: s200,
      300: s300,
      400: s400,
      500: s500,
      600: s600,
      700: s700,
      800: s800,
      900: s900,
    };
  }

  MaterialColor toMaterialColor() {
    return MaterialColor(_value, toSwatch());
  }
}
