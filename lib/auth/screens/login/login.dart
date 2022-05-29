import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles.dart';

import '../../../common/app_widgets.dart';
import '../../../common/utils/ui_utils.dart';
import 'login_form.dart';
import 'login_state.dart';

class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginStateProvider);
    final notifier = ref.read(loginStateProvider.notifier);

    ref.listen<LoginState>(loginStateProvider, (prev, next) {
      if (next is LoginError) {
        UiUtils.maybeShowSnackbar(context, next.error.message);
      }
    });

    return Scaffold(
      body: Loading(
        condition: state is LoginLoading,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: SingleChildScrollView(
              child: AppColumn(
                spacing: AppSpacing.l,
                children: [
                  const Header('Autentificare'),
                  LoginForm(),
                  AppButton(
                    onPressed: notifier.logInWithGoogle,
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
