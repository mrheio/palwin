import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/ui_utils.dart';

class LoginFormState {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginFormState();

  void dispose() {
    UiUtils.disposeControllers([
      emailController,
      passwordController,
    ]);
  }

  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();
}

final loginFormStateProvider = Provider.autoDispose((ref) {
  final loginFormState = LoginFormState();
  ref.onDispose(() {
    loginFormState.dispose();
  });
  return loginFormState;
});
