import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/ui_utils.dart';

class RegisterFormState {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    UiUtils.disposeControllers([
      emailController,
      usernameController,
      passwordController,
    ]);
  }

  String get email => emailController.text.trim();
  String get username => usernameController.text.trim();
  String get password => passwordController.text.trim();
}

final registerFormStateProvider = Provider.autoDispose((ref) {
  final registerFormState = RegisterFormState();
  return registerFormState;
});
