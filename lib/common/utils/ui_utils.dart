import 'package:flutter/material.dart';

enum SnackbarStyle { info, success, error, warning }

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
}

GlobalKey<FormState> createFormKey([GlobalKey<FormState>? formKey]) {
  return formKey ?? GlobalKey<FormState>();
}

TextEditingController createTextEditingController(
    [TextEditingController? controller]) {
  return controller ?? TextEditingController();
}

String getText(TextEditingController controller) => controller.text.trim();

void disposeControllers(List<TextEditingController> controllers) {
  for (final controller in controllers) {
    controller.dispose();
  }
}
