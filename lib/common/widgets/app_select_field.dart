import 'package:flutter/material.dart';

import '../errors/err.dart';
import '../styles.dart';

class AppSelectField<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final void Function(T?)? onChanged;
  final List<void Function(T?)>? validators;
  final String? hint;
  final Widget Function(T e) displayMapper;
  final T Function(T e)? valueMapper;

  const AppSelectField({
    this.items = const [],
    this.value,
    this.onChanged,
    this.validators,
    this.hint,
    required this.displayMapper,
    this.valueMapper,
    Key? key,
  }) : super(key: key);

  String? _validator(T? value) {
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
    return DropdownButtonFormField<T>(
      value: value,
      items: items
          .map((e) => DropdownMenuItem<T>(
                value: valueMapper?.call(e) ?? e,
                child: displayMapper(e),
              ))
          .toList(),
      onChanged: onChanged,
      validator: _validator,
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
    );
  }
}
