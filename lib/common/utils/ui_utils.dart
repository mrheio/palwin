import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrouter/vrouter.dart';

class UiUtils {
  const UiUtils._();

  static disposeControllers(List<TextEditingController> controllers) {
    for (final controller in controllers) {
      controller.dispose();
    }
  }

  static clearFields(List<TextEditingController> controllers) {
    for (final controller in controllers) {
      controller.clear();
    }
  }

  static showSnackbar(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static maybeShowSnackbar(BuildContext context, String? message) {
    if (message != null && message.isNotEmpty) {
      showSnackbar(context, message);
    }
  }

  static maybePop(BuildContext context, bool condition) {
    if (condition) {
      VRouter.of(context).pop();
    }
  }
}
