import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:input_validator/input_validator.dart';
import 'package:noctur/common/styles/app_spacing.dart';
import 'package:noctur/common/utils.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:styles/styles.dart';

import '../../acccount/providers.dart';
import '../providers.dart';

class ManageAccountView extends ConsumerStatefulWidget {
  const ManageAccountView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ManageAccountState();
  }
}

class _ManageAccountState extends ConsumerState<ManageAccountView> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController usernameController;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authStateProvider).user!;
    emailController = TextEditingController(text: user.email);
    usernameController = TextEditingController(text: user.username);
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  Future<void> updateAccount() async {
    if (formKey.currentState!.validate()) {
      await ref
          .read(accountStateProvider.notifier)
          .updateUsername(getText(usernameController));
    }
  }

  Future<void> logOut() async {
    await ref.read(authStateProvider.notifier).logOut();
  }

  @override
  Widget build(BuildContext context) {
    final accountState = ref.watch(accountStateProvider);

    if (accountState is LoadingStatus) {
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
                enabled: false,
              ),
              StyledTextField(
                label: 'Username',
                controller: usernameController,
                validator: const InputValidator().notEmpty().create(),
              ),
              StyledButtonFluid(
                onPressed: updateAccount,
                child: const Text('Actualizeaza date'),
              ),
              StyledButtonFluid(
                onPressed: logOut,
                child: const Text('Iesi din cont'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
