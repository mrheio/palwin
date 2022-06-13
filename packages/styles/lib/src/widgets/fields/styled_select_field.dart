import 'package:flutter/material.dart';
import 'package:styles/src/widgets/fields/field_styles.dart';
import 'package:styles/src/widgets/layout/styled_column.dart';

import 'field_label.dart';

class StyledSelectField<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final void Function(T?)? onChanged;
  final String? hint;
  final Widget Function(T e) displayMapper;
  final T Function(T e)? valueMapper;
  final String? label;
  final FieldVariant variant;
  final String? Function(T?)? validator;

  const StyledSelectField({
    this.items = const [],
    this.value,
    this.onChanged,
    this.hint,
    required this.displayMapper,
    this.valueMapper,
    this.label,
    this.variant = FieldVariant.primary,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectField = DropdownButtonFormField<T>(
      isExpanded: true,
      value: value,
      items: items
          .map(
            (e) => DropdownMenuItem<T>(
              value: valueMapper?.call(e) ?? e,
              child: displayMapper(e),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator,
    );

    if (label != null) {
      return StyledColumn(
        gap: 8,
        children: [
          FieldLabel(label!),
          selectField,
        ],
      );
    }

    return selectField;
  }
}
