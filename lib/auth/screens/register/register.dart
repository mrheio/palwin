import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/screens/register/register_form.dart';
import 'package:noctur/auth/screens/register/register_state.dart';
import 'package:noctur/common/utils/ui_utils.dart';
import 'package:noctur/common/widgets/app_column.dart';
import 'package:noctur/common/widgets/header.dart';
import 'package:noctur/common/widgets/loading.dart';

class Register extends ConsumerWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerStateNotifierProvider);

    ref.listen<RegisterState>(registerStateNotifierProvider, (prev, next) {
      final error = next.error;
      final success = next.success;
      if (error != null) {
        UiUtils.showSnackbar(context, error.message);
      }
      if (success != null) {}
    });

    return Scaffold(
      body: Loading(
        condition: registerState.loading,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: AppColumn(
                spacing: 24,
                children: [
                  const Header('Inregistrare'),
                  RegisterForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
