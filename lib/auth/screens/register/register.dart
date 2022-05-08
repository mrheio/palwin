import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/screens/register/register_form.dart';
import 'package:noctur/auth/screens/register/register_state.dart';
import 'package:noctur/common/utils/ui_utils.dart';
import 'package:noctur/common/widgets/loading.dart';

class Register extends ConsumerWidget {
  final GlobalKey<FormState> _formKey;

  Register({Key? key})
      : _formKey = GlobalKey<FormState>(),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerStateNotifierProvider);

    ref.listen<RegisterState>(registerStateNotifierProvider, (prev, next) {
      final error = next.error;
      if (error != null) {
        UiUtils.showSnackbar(context, error.message);
      }
    });

    return Scaffold(
      body: Loading(
        condition: registerState.loading,
        child: Container(
          margin: EdgeInsets.all(16),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
