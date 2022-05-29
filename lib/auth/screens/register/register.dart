import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles.dart';

import '../../../common/utils/ui_utils.dart';
import '../../../common/widgets/app_column.dart';
import '../../../common/widgets/header.dart';
import '../../../common/widgets/loading.dart';
import 'register_form.dart';
import 'register_state.dart';

class Register extends ConsumerWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerStateProvider);

    ref.listen<RegisterState>(registerStateProvider, (prev, next) {
      if (next is RegisterError) {
        UiUtils.maybeShowSnackbar(context, next.error.message);
      }
    });

    return Scaffold(
      body: Loading(
        condition: state is RegisterLoading,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.m),
          child: Center(
            child: SingleChildScrollView(
              child: AppColumn(
                spacing: AppSpacing.l,
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
