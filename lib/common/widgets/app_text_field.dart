import 'package:flutter/material.dart';
import 'package:noctur/common/errors/err.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final List<void Function(String?)>? validators;
  final bool obscureText;

  const AppTextField({
    this.controller,
    this.hint,
    this.validators,
    this.obscureText = false,
    Key? key,
  }) : super(key: key);

  String? _validator(String? value) {
    if (validators != null) {
      for (var validator in validators!) {
        try {
          validator(value);
        } on Err catch (error) {
          return error.message;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      validator: _validator,
      obscureText: obscureText,
    );
  }
}
