import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/auth_providers.dart';
import 'package:noctur/auth/auth_service.dart';
import 'package:noctur/common/errors/err.dart';
import 'package:optional/optional.dart';

import '../../../common/success.dart';

class RegisterState {
  final TextEditingController emailField;
  final TextEditingController usernameField;
  final TextEditingController passwordField;
  final bool loading;
  final Err? error;
  final Success? success;

  RegisterState({
    TextEditingController? emailField,
    TextEditingController? usernameField,
    TextEditingController? passwordField,
    this.loading = false,
    this.error,
    this.success,
  })  : emailField = emailField ?? TextEditingController(),
        usernameField = usernameField ?? TextEditingController(),
        passwordField = passwordField ?? TextEditingController();

  void dispose() {
    emailField.dispose();
    usernameField.dispose();
    passwordField.dispose();
  }

  RegisterState copyWith({
    bool? loading,
    Optional<Err>? error,
    Optional<Success>? success,
  }) {
    return RegisterState(
      emailField: emailField,
      usernameField: usernameField,
      passwordField: passwordField,
      loading: loading ?? this.loading,
      error: error != null ? error.orElseNull : this.error,
      success: success != null ? success.orElseNull : this.success,
    );
  }
}

class RegisterStateNotifier extends StateNotifier<RegisterState> {
  final AuthService _authService;

  RegisterStateNotifier(this._authService) : super(RegisterState());

  Future<void> register() async {
    state = state.copyWith(
        loading: true,
        error: const Optional.empty(),
        success: const Optional.empty());
    try {
      final email = state.emailField.text.trim();
      final username = state.usernameField.text.trim();
      final password = state.passwordField.text.trim();
      await _authService.register(
          email: email, username: username, password: password);
      state =
          state.copyWith(loading: false, success: Optional.of(const Success()));
    } on Err catch (error) {
      state = state.copyWith(loading: false, error: Optional.of(error));
    }
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}

final registerStateNotifierProvider =
    StateNotifierProvider.autoDispose<RegisterStateNotifier, RegisterState>(
        (ref) {
  final authService = ref.read(authServiceProvider);
  return RegisterStateNotifier(authService);
});
