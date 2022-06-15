import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles/app_color.dart';

const _darkTextTheme = TextTheme(
  headline1: TextStyle(color: AppColor.text),
  headline2: TextStyle(color: AppColor.text),
  bodyText2: TextStyle(color: AppColor.text),
  subtitle1: TextStyle(color: AppColor.textDimmed),
);

final _darkButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    primary: AppColor.primary[50],
  ),
);

const _inputBorderWidth = 2.0;
const _inputBorderRadius = BorderRadius.all(Radius.circular(4));

const _noBorder = OutlineInputBorder(borderRadius: _inputBorderRadius);

InputBorder _createInputBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(
      color: color,
      width: _inputBorderWidth,
    ),
  );
}

final _focusedInputBorder = _createInputBorder(AppColor.primary[40]!);

final _inputDecorationTheme = InputDecorationTheme(
  filled: true,
  fillColor: AppColor.primary[80],
  border: _noBorder,
  enabledBorder: _noBorder,
  focusedBorder: _focusedInputBorder,
  errorBorder: _createInputBorder(AppColor.error),
  focusedErrorBorder: _focusedInputBorder,
  errorStyle: const TextStyle(
    color: AppColor.error,
  ),
  suffixIconColor: AppColor.text,
);

final _progressIndicatorTheme = const ProgressIndicatorThemeData().copyWith(
  color: AppColor.secondary[50],
);

final _textSelectionTheme = const TextSelectionThemeData().copyWith(
  cursorColor: AppColor.text,
);

class AppStyles {
  final darkTheme = ThemeData.dark().copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColor.primary[50]!,
      primary: AppColor.primary[50],
      secondary: AppColor.secondary[50]!,
    ),
    scaffoldBackgroundColor: AppColor.bg,
    textTheme: _darkTextTheme,
    elevatedButtonTheme: _darkButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    progressIndicatorTheme: _progressIndicatorTheme,
    textSelectionTheme: _textSelectionTheme,
    splashColor: AppColor.primary[90],
  );

  final lightTheme = ThemeData.light();
}

final stylesProvider = Provider((ref) {
  final styles = AppStyles();
  return styles;
});

class AppStylesFlex {
  final theme = FlexColorScheme.dark(
    usedColors: 2,
    primary: AppColor.primary[50],
    onPrimary: AppColor.text,
    secondary: AppColor.secondary[50],
    error: AppColor.error,
    background: AppColor.bg,
    onBackground: AppColor.text,
    scaffoldBackground: AppColor.bg,
    tabBarStyle: FlexTabBarStyle.forBackground,
    subThemesData: const FlexSubThemesData(
      inputDecoratorBorderType: FlexInputBorderType.outline,
      inputDecoratorRadius: 12,
    ),
  );

  ThemeData get themeData => theme.toTheme;
}

final stylesFlexProvider = Provider((ref) {
  final styles = AppStylesFlex();
  return styles;
});
