import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/errors/err.dart';
import '../../auth_providers.dart';
import '../../auth_service.dart';
import '../../google_auth_service.dart';
import 'login_form_state.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInit extends LoginState {
  const LoginInit();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  const LoginSuccess();
}

class LoginError extends LoginState {
  final Err error;

  const LoginError(this.error);
}

class LoginStateNotifier extends StateNotifier<LoginState> {
  final AuthService _authService;
  final GoogleAuthService _googleAuthService;
  final LoginFormState _formState;

  LoginStateNotifier(
    this._authService,
    this._googleAuthService,
    this._formState,
  ) : super(const LoginInit());

  Future<void> logIn() async {
    state = const LoginLoading();
    try {
      await _authService.logInWithEmailAndPassword(
        email: _formState.email,
        password: _formState.password,
      );
      state = const LoginSuccess();
    } on Err catch (error) {
      state = LoginError(error);
    }
  }

  Future<void> logInWithGoogle() async {
    await _googleAuthService.logInWithGoogle();
  }
}

final loginStateProvider =
    StateNotifierProvider.autoDispose<LoginStateNotifier, LoginState>((ref) {
  final authService = ref.read(authServiceProvider);
  final googleAuthService = ref.read(googleAuthServiceProvider);
  final formState = ref.watch(loginFormStateProvider);
  return LoginStateNotifier(authService, googleAuthService, formState);
});
