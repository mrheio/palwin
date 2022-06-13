import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/logic/auth_service.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/common/app_utils.dart';
import 'package:noctur/common/exceptions/auth_exception.dart';
import 'package:noctur/common/success.dart';
import 'package:noctur/common/utils/disposable_state.dart';
import 'package:optional/optional.dart';

class RegisterState extends DisposableState {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final bool loading;
  final Optional<Success> success;
  final Optional<AuthException> error;

  RegisterState({
    RegisterState? prev,
    this.loading = false,
    this.success = const Optional.empty(),
    this.error = const Optional.empty(),
  })  : emailController = createTextEditingController(prev?.emailController),
        usernameController =
            createTextEditingController(prev?.usernameController),
        passwordController =
            createTextEditingController(prev?.passwordController);

  String get email => emailController.text.trim();
  String get username => usernameController.text.trim();
  String get password => passwordController.text.trim();

  @override
  void onDispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  RegisterState copyWith({
    bool? loading,
    Success? success,
    AuthException? error,
  }) {
    return RegisterState(
      prev: this,
      loading: loading ?? false,
      success: Optional.ofNullable(success),
      error: Optional.ofNullable(error),
    );
  }
}

class RegisterNotifier extends DisposableStateNotifier<RegisterState> {
  final AuthService _authService;

  RegisterNotifier(this._authService) : super(RegisterState());

  Future<void> register() async {
    state = state.copyWith(loading: true);
    try {
      await _authService.register(
          email: state.email,
          username: state.username,
          password: state.password);
    } on AuthException catch (error) {
      state = state.copyWith(error: error);
    }
  }
}

final registerStateProvider =
    StateNotifierProvider.autoDispose<RegisterNotifier, RegisterState>((ref) {
  final authService = ref.read(authServiceProvider);
  return RegisterNotifier(authService);
});

registerEffectProvider(BuildContext context) => Provider.autoDispose((ref) {
      ref.listen<RegisterState>(registerStateProvider, (prev, next) {
        if (next.error.isPresent) {
          AppSnackbar.fromErr(next.error.value).show(context);
        }
      });
    });
