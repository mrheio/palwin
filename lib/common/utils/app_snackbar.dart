import 'package:flutter/material.dart';
import 'package:super_rich_text/super_rich_text.dart';

import '../exceptions/custom_exception.dart';
import '../styles/app_color.dart';
import '../success.dart';

class AppSnackbar {
  final SnackBar _snackBar;

  AppSnackbar._(
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

  factory AppSnackbar.success(String message) {
    return AppSnackbar._(
      message,
      textColor: AppColor.textInverted,
      bgColor: AppColor.success,
    );
  }

  factory AppSnackbar.fromSuccess(Success success) {
    return AppSnackbar.success(success.message);
  }

  factory AppSnackbar.error(String message) {
    return AppSnackbar._(
      message,
      textColor: AppColor.text,
      bgColor: AppColor.error,
    );
  }

  factory AppSnackbar.fromErr(CustomException error) {
    return AppSnackbar.error(error.message);
  }

  factory AppSnackbar.errorFromObject(Object error) {
    if (error is CustomException) {
      return AppSnackbar.fromErr(error);
    }
    if (error is String) {
      return AppSnackbar.error(error);
    }
    throw UnimplementedError();
  }

  factory AppSnackbar.warning(String message) {
    return AppSnackbar._(
      message,
      textColor: AppColor.textInverted,
      bgColor: AppColor.warning,
    );
  }

  factory AppSnackbar.info(String message) {
    return AppSnackbar._(message);
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
