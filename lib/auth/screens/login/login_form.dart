import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles.dart';

import '../../../common/app_widgets.dart';
import '../../../common/utils/validator.dart';
import 'login_form_state.dart';
import 'login_state.dart';

class LoginForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey;

  LoginForm({Key? key})
      : _formKey = GlobalKey<FormState>(),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginFormStateProvider);
    final notifier = ref.read(loginStateProvider.notifier);

    Future<void> handleLogin() async {
      if (_formKey.currentState!.validate()) {
        await notifier.logIn();
      }
    }

    return Form(
      key: _formKey,
      child: AppColumn(
        spacing: AppSpacing.m,
        children: [
          AppTextField(
            controller: state.emailController,
            hint: 'Email',
            validators: const [Validator.required, Validator.email],
          ),
          AppTextField(
            controller: state.passwordController,
            hint: 'Parola',
            validators: const [Validator.required],
            obscureText: true,
          ),
          AppButton(
            onPressed: handleLogin,
            child: const Text('Intra in cont'),
            fillWidth: true,
          ),
        ],
      ),
    );
  }
}
