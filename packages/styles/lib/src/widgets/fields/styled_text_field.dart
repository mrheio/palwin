import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styles/src/utils/types.dart';
import 'package:styles/src/widgets/fields/field_label.dart';
import 'package:styles/src/widgets/fields/field_styles.dart';
import 'package:styles/src/widgets/layout/styled_column.dart';

class StyledTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final bool secret;
  final SubmitCallback? onSubmit;
  final int? maxLines;
  final ChangedCallback? onChanged;
  final bool enabled;
  final FieldVariant variant;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const StyledTextField({
    this.controller,
    this.label,
    this.secret = false,
    this.onChanged,
    this.onSubmit,
    this.maxLines,
    this.enabled = true,
    this.variant = FieldVariant.primary,
    this.validator,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textField = TextFormField(
      controller: controller,
      obscureText: secret,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      enabled: enabled,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(suffixIcon: suffixIcon),
    );

    if (label != null) {
      return StyledColumn(
        gap: 8,
        children: [
          FieldLabel(label!),
          textField,
        ],
      );
    }

    return textField;
  }
}
