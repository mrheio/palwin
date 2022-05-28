import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/errors/err.dart';
import '../../auth_providers.dart';
import '../../auth_service.dart';
import 'register_form_state.dart';

abstract class RegisterState {
  const RegisterState();
}

class RegisterInit extends RegisterState {
  const RegisterInit();
}

class RegisterLoading extends RegisterState {
  const RegisterLoading();
}

class RegisterSuccess extends RegisterState {
  const RegisterSuccess();
}

class RegisterError extends RegisterState {
  final Err error;

  const RegisterError(this.error);
}

class RegisterNotifier extends StateNotifier<RegisterState> {
  final AuthService _authService;
  final RegisterFormState _formState;

  RegisterNotifier(this._authService, this._formState)
      : super(const RegisterInit());

  Future<void> register() async {
    state = const RegisterLoading();
    try {
      await _authService.register(
        email: _formState.email,
        username: _formState.username,
        password: _formState.password,
      );
      state = const RegisterSuccess();
    } on Err catch (error) {
      state = RegisterError(error);
    }
  }
}

final registerStateProvider =
    StateNotifierProvider.autoDispose<RegisterNotifier, RegisterState>((ref) {
  final authService = ref.read(authServiceProvider);
  final formState = ref.watch(registerFormStateProvider);
  return RegisterNotifier(authService, formState);
});
