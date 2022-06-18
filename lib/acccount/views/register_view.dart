import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:input_validator/input_validator.dart';
import 'package:noctur/common/styles/app_spacing.dart';
import 'package:noctur/common/utils.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:styles/styles.dart';

import '../providers.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends ConsumerState<RegisterView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (formKey.currentState!.validate()) {
      await ref.read(authStateProvider.notifier).register(
          getText(emailController),
          getText(usernameController),
          getText(passwordController));
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(authStateProvider.select((value) => value.status));

    if (status is LoadingStatus) {
      return const Loading();
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: StyledColumn(
            gap: AppSpacing.m,
            children: [
              StyledTextField(
                label: 'Email',
                controller: emailController,
                validator: const InputValidator().notEmpty().email().create(),
              ),
              StyledTextField(
                label: 'Username',
                controller: usernameController,
                validator:
                    const InputValidator().notEmpty().minLength(3).create(),
              ),
              StyledTextField(
                label: 'Parola',
                controller: passwordController,
                secret: true,
                validator: const InputValidator()
                    .notEmpty()
                    .minLength(8)
                    .hasUppercase()
                    .create(),
              ),
              StyledButtonFluid(
                onPressed: register,
                child: const StyledText('Inregistrare'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
