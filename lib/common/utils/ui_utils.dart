import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UiUtils {
  const UiUtils._();

  static showSnackbar(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
