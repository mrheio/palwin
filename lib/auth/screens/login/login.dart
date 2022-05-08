import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/screens/login/login_form.dart';
import 'package:noctur/auth/screens/login/login_state.dart';
import 'package:noctur/common/utils/ui_utils.dart';
import 'package:noctur/common/widgets/loading.dart';

class Login extends ConsumerWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginStateNotifierProvider);
    final loginNotifier = ref.read(loginStateNotifierProvider.notifier);

    ref.listen<LoginState>(loginStateNotifierProvider, (prev, next) {
      final error = next.error;
      if (error != null) {
        UiUtils.showSnackbar(context, error.message);
      }
    });

    return Scaffold(
      body: Loading(
        condition: loginState.loading,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginForm(),
              ElevatedButton(
                onPressed: loginNotifier.logInWithGoogle,
                child: const Text('Intra in cont cu Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
