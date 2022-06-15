import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:input_validator/input_validator.dart';
import 'package:noctur/acccount/views/login_view/login_state.dart';
import 'package:noctur/common/styles/app_spacing.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:styles/styles.dart';

class LoginView extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginStateProvider);
    final notifier = ref.read(loginStateProvider.notifier);
    ref.watch(loginEffectProvider(context));

    if (state.loading) {
      return const Loading();
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: StyledColumn(
            gap: AppSpacing.m,
            children: [
              StyledTextField(
                label: 'Email',
                controller: state.emailController,
                validator: const InputValidator().notEmpty().email().create(),
              ),
              StyledTextField(
                label: 'Parola',
                controller: state.passwordController,
                secret: true,
                validator:
                    const InputValidator().notEmpty().minLength(6).create(),
              ),
              StyledButtonFluid(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    notifier.logIn();
                  }
                },
                child: const StyledText('Intra in cont'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
