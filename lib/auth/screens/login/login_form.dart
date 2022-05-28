import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/validator.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_column.dart';
import '../../../common/widgets/app_text_field.dart';
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

    return Form(
      key: _formKey,
      child: AppColumn(
        spacing: 16,
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
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                notifier.logIn();
              }
            },
            child: const Text('Intra in cont'),
            fillWidth: true,
          ),
        ],
      ),
    );
  }
}
