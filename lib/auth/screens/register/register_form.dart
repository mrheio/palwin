import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles.dart';

import '../../../common/utils/validator.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_column.dart';
import '../../../common/widgets/app_text_field.dart';
import 'register_form_state.dart';
import 'register_state.dart';

class RegisterForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey;

  RegisterForm({Key? key})
      : _formKey = GlobalKey<FormState>(),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(registerFormStateProvider);
    final notifier = ref.read(registerStateProvider.notifier);

    Future<void> handleRegister() async {
      if (_formKey.currentState!.validate()) {
        await notifier.register();
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
            controller: state.usernameController,
            hint: 'Username',
            validators: const [Validator.required],
          ),
          AppTextField(
            controller: state.passwordController,
            hint: 'Parola',
            validators: const [Validator.required],
            obscureText: true,
          ),
          AppButton(
            onPressed: handleRegister,
            child: const Text('Creeaza cont'),
            fillWidth: true,
          ),
        ],
      ),
    );
  }
}
