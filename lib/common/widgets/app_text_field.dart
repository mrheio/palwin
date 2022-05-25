import 'package:flutter/material.dart';
import 'package:noctur/common/errors/err.dart';
import 'package:noctur/common/styles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final List<void Function(String?)>? validators;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmit;
  final EdgeInsetsGeometry margin;
  final int? maxLines;
  final void Function(String)? onChanged;

  const AppTextField({
    this.controller,
    this.hint,
    this.validators,
    this.obscureText = false,
    this.textInputAction,
    this.onSubmit,
    this.margin = EdgeInsets.zero,
    this.maxLines = 1,
    this.onChanged,
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
    return Padding(
      padding: margin,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.primary[40]!,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.error,
            ),
          ),
          filled: true,
          fillColor: AppColor.primary[70],
        ),
        validator: _validator,
        obscureText: obscureText,
        textInputAction: textInputAction,
        onFieldSubmitted: onSubmit,
        maxLines: maxLines,
        onChanged: onChanged,
      ),
    );
  }
}
