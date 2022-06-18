import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:input_validator/input_validator.dart';
import 'package:noctur/common/styles/app_spacing.dart';
import 'package:noctur/common/utils.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:styles/styles.dart';

import '../providers.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends ConsumerState<LoginView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> logIn() async {
    if (formKey.currentState!.validate()) {
      ref
          .read(authStateProvider.notifier)
          .logIn(getText(emailController), getText(passwordController));
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(authStateProvider).status;

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
                label: 'Parola',
                controller: passwordController,
                secret: true,
                validator: const InputValidator().notEmpty().create(),
              ),
              StyledButtonFluid(
                onPressed: logIn,
                child: const StyledText('Intra in cont'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
