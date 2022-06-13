import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:input_validator/input_validator.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/common/styles/app_spacing.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/user/views/manage_account_view.dart/manage_account_state.dart';
import 'package:styles/styles.dart';

class ManageAccountView extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ManageAccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(manageAccountStateProvider);
    final notifier = ref.read(manageAccountStateProvider.notifier);
    ref.watch(manageAccountEffectProvider(context));

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
                enabled: false,
              ),
              StyledTextField(
                label: 'Username',
                controller: state.usernameController,
                validator: const InputValidator().notEmpty().create(),
              ),
              StyledButtonFluid(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    notifier.updateAccount();
                  }
                },
                child: const Text('Actualizeaza date'),
              ),
              StyledButtonFluid(
                onPressed: () => ref.read(authServiceProvider).logOut(),
                child: const Text('Iesi din cont'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
