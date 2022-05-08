import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/screens/register/register_state.dart';
import 'package:noctur/common/utils/validator.dart';
import 'package:noctur/common/widgets/app_text_field.dart';

class RegisterForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey;

  RegisterForm({Key? key})
      : _formKey = GlobalKey<FormState>(),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerStateNotifierProvider);
    final registerNotifier = ref.read(registerStateNotifierProvider.notifier);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppTextField(
            controller: registerState.emailField,
            hint: 'Email',
            validators: const [Validator.required, Validator.email],
          ),
          AppTextField(
            controller: registerState.usernameField,
            hint: 'Username',
            validators: const [Validator.required],
          ),
          AppTextField(
            controller: registerState.passwordField,
            hint: 'Parola',
            validators: const [Validator.required],
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                registerNotifier.register();
              }
            },
            child: const Text('Creeaza cont'),
          ),
        ],
      ),
    );
  }
}
