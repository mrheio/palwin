import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/screens/login/login_state.dart';
import 'package:noctur/common/utils/validator.dart';
import 'package:noctur/common/widgets/app_text_field.dart';

class LoginForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey;

  LoginForm({Key? key})
      : _formKey = GlobalKey<FormState>(),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginStateNotifierProvider);
    final loginNotifier = ref.watch(loginStateNotifierProvider.notifier);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextField(
            controller: loginState.emailField,
            hint: 'Email',
            validators: const [Validator.required, Validator.email],
          ),
          AppTextField(
            controller: loginState.passwordField,
            hint: 'Parola',
            validators: const [Validator.required],
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                loginNotifier.logIn();
              }
            },
            child: const Text('Intra in cont'),
          ),
        ],
      ),
    );
  }
}
