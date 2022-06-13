import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/logic/account_service.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/common/app_utils.dart';
import 'package:noctur/common/exceptions/custom_exception.dart';
import 'package:noctur/common/success.dart';
import 'package:noctur/common/utils/disposable_state.dart';
import 'package:noctur/user/logic/logic.dart';
import 'package:optional/optional.dart';

class ManageAccountState implements DisposableState {
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final bool isDataChanged;
  final bool loading;
  final Optional<Success> success;
  final Optional<CustomException> error;

  ManageAccountState({
    ManageAccountState? prev,
    this.isDataChanged = false,
    this.loading = false,
    this.success = const Optional.empty(),
    this.error = const Optional.empty(),
  })  : emailController = createTextEditingController(prev?.emailController),
        usernameController =
            createTextEditingController(prev?.usernameController);

  String get email => emailController.text.trim();
  String get username => usernameController.text.trim();

  @override
  void onDispose() {
    emailController.dispose();
    usernameController.dispose();
  }

  ManageAccountState copyWith({
    bool? isDataChanged,
    bool? loading,
    Success? success,
    CustomException? error,
  }) {
    return ManageAccountState(
      prev: this,
      isDataChanged: isDataChanged ?? this.isDataChanged,
      loading: loading ?? false,
      success: Optional.ofNullable(success),
      error: Optional.ofNullable(error),
    );
  }
}

class ManageAccountNotifier
    extends DisposableStateNotifier<ManageAccountState> {
  final AccountService _accountService;

  ManageAccountNotifier(this._accountService) : super(ManageAccountState());

  void setData(ComplexUser user) {
    state.emailController.text = user.email;
    state.usernameController.text = user.username;
  }

  Future<void> updateAccount() async {
    state = state.copyWith(loading: true);
    try {
      await _accountService.updateUsername(state.username);
      state = state.copyWith(success: const Success('Date actualizate'));
    } on CustomException catch (error) {
      state = state.copyWith(error: error);
    }
  }
}

final manageAccountStateProvider = StateNotifierProvider.autoDispose<
    ManageAccountNotifier, ManageAccountState>((ref) {
  final accountService = ref.read(accountServiceProvider);
  final user = ref.read(userProvider$).value;
  return ManageAccountNotifier(accountService)..setData(user!.value);
});

manageAccountEffectProvider(BuildContext context) =>
    Provider.autoDispose((ref) {
      ref.listen<ManageAccountState>(manageAccountStateProvider, (prev, next) {
        if (next.error.isPresent) {
          AppSnackbar.fromErr(next.error.value).show(context);
        }
        if (next.success.isPresent) {
          AppSnackbar.fromSuccess(next.success.value).show(context);
        }
      });
    });
