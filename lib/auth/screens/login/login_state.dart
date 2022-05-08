import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/auth_providers.dart';
import 'package:noctur/auth/auth_service.dart';
import 'package:noctur/auth/google_auth_service.dart';
import 'package:optional/optional.dart';

import '../../../common/errors/err.dart';

class LoginState {
  final TextEditingController emailField;
  final TextEditingController passwordField;
  final bool loading;
  final Err? error;

  LoginState({
    TextEditingController? emailField,
    TextEditingController? passwordField,
    this.loading = false,
    this.error,
  })  : emailField = emailField ?? TextEditingController(),
        passwordField = passwordField ?? TextEditingController();

  void dispose() {
    emailField.dispose();
    passwordField.dispose();
  }

  LoginState copyWith({bool? loading, Optional<Err>? error}) {
    return LoginState(
      emailField: emailField,
      passwordField: passwordField,
      loading: loading ?? this.loading,
      error: error != null ? error.orElseNull : this.error,
    );
  }
}

class LoginStateNotifier extends StateNotifier<LoginState> {
  final AuthService _authService;
  final GoogleAuthService _googleAuthService;

  LoginStateNotifier(this._authService, this._googleAuthService)
      : super(LoginState());

  Future<void> logIn() async {
    state = state.copyWith(loading: true, error: const Optional.empty());
    try {
      final email = state.emailField.text.trim();
      final password = state.passwordField.text.trim();
      await _authService.logInWithEmailAndPassword(
          email: email, password: password);
      state = state.copyWith(loading: false);
    } on Err catch (error) {
      state = state.copyWith(loading: false, error: Optional.of(error));
    }
  }

  Future<void> logInWithGoogle() async {
    await _googleAuthService.logInWithGoogle();
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}

final loginStateNotifierProvider =
    StateNotifierProvider.autoDispose<LoginStateNotifier, LoginState>((ref) {
  final authService = ref.read(authServiceProvider);
  final googleAuthService = ref.read(googleAuthServiceProvider);
  return LoginStateNotifier(authService, googleAuthService);
});
