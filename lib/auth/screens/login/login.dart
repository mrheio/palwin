import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/ui_utils.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_column.dart';
import '../../../common/widgets/header.dart';
import '../../../common/widgets/loading.dart';
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
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: AppColumn(
                spacing: 24,
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
