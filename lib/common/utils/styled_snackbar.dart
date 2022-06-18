import 'package:flutter/material.dart';
import 'package:super_rich_text/super_rich_text.dart';

import '../exceptions/custom_exception.dart';
import '../styles/app_color.dart';
import '../success.dart';

class StyledSnackbar {
  final SnackBar _snackBar;

  StyledSnackbar._(
    String message, {
    Color textColor = AppColor.text,
    Color bgColor = AppColor.info,
  }) : _snackBar = SnackBar(
          content: SuperRichText(
            text: message,
            style: TextStyle(color: textColor),
          ),
          backgroundColor: bgColor,
          behavior: SnackBarBehavior.floating,
        );

  factory StyledSnackbar.success(String message) {
    return StyledSnackbar._(
      message,
      textColor: AppColor.textInverted,
      bgColor: AppColor.success,
    );
  }

  factory StyledSnackbar.fromSuccess(Success success) {
    return StyledSnackbar.success(success.message);
  }

  factory StyledSnackbar.error(String message) {
    return StyledSnackbar._(
      message,
      textColor: AppColor.text,
      bgColor: AppColor.error,
    );
  }

  factory StyledSnackbar.fromException(CustomException error) {
    return StyledSnackbar.error(error.message);
  }

  factory StyledSnackbar.warning(String message) {
    return StyledSnackbar._(
      message,
      textColor: AppColor.textInverted,
      bgColor: AppColor.warning,
    );
  }

  factory StyledSnackbar.info(String message) {
    return StyledSnackbar._(message);
  }

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }

  void showIf(BuildContext context, bool condition) {
    if (condition) {
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    }
  }
}
