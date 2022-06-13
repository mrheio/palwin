import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/logic/auth_service.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/common/app_utils.dart';
import 'package:noctur/common/exceptions/auth_exception.dart';
import 'package:noctur/common/success.dart';
import 'package:noctur/common/utils/disposable_state.dart';
import 'package:optional/optional.dart';

class LoginState extends DisposableState {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool loading;
  final Optional<Success> success;
  final Optional<AuthException> error;

  LoginState({
    LoginState? prev,
    this.loading = false,
    this.success = const Optional.empty(),
    this.error = const Optional.empty(),
  })  : emailController = createTextEditingController(prev?.emailController),
        passwordController =
            createTextEditingController(prev?.passwordController);

  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();

  @override
  void onDispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  LoginState copyWith({bool? loading, Success? success, AuthException? error}) {
    return LoginState(
      prev: this,
      loading: loading ?? false,
      success: Optional.ofNullable(success),
      error: Optional.ofNullable(error),
    );
  }
}

class LoginNotifier extends DisposableStateNotifier<LoginState> {
  final AuthService _authService;

  LoginNotifier(this._authService) : super(LoginState());

  Future<void> logIn() async {
    state = state.copyWith(loading: true);
    try {
      await _authService.logInWithEmailAndPassword(
          email: state.email, password: state.password);
    } on AuthException catch (error) {
      state = state.copyWith(error: error);
    }
  }
}

final loginStateProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginState>((ref) {
  final authService = ref.read(authServiceProvider);
  return LoginNotifier(authService);
});

loginEffectProvider(BuildContext context) => Provider.autoDispose((ref) {
      ref.listen<LoginState>(loginStateProvider, (prev, next) {
        if (next.error.isPresent) {
          AppSnackbar.fromErr(next.error.value).show(context);
        }
      });
    });
