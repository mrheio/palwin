import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/screens/login/login_form.dart';
import 'package:noctur/auth/screens/login/login_state.dart';
import 'package:noctur/common/utils/ui_utils.dart';
import 'package:noctur/common/widgets/app_button.dart';
import 'package:noctur/common/widgets/app_column.dart';
import 'package:noctur/common/widgets/header.dart';
import 'package:noctur/common/widgets/loading.dart';

class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginStateNotifierProvider);
    final loginNotifier = ref.read(loginStateNotifierProvider.notifier);

    ref.listen<LoginState>(loginStateNotifierProvider, (prev, next) {
      final error = next.error;
      final success = next.success;
      if (error != null) {
        UiUtils.showSnackbar(context, error.message);
      }
      if (success != null) {}
    });

    return Scaffold(
      body: Loading(
        condition: loginState.loading,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: AppColumn(
                spacing: 24,
                children: [
                  const Header('Autentificare'),
                  LoginForm(),
                  AppButton(
                    onPressed: loginNotifier.logInWithGoogle,
                    child: const Text('Intra in cont cu Google'),
                    fillWidth: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
