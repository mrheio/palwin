import 'package:flutter/material.dart';

enum FieldVariant { primary, secondary, naked }

Color _pickFillColor(BuildContext context, FieldVariant variant) {
  final colorScheme = Theme.of(context).colorScheme;
  switch (variant) {
    case FieldVariant.primary:
      return colorScheme.primary;
    case FieldVariant.secondary:
      return colorScheme.secondary;
    case FieldVariant.naked:
      return Colors.transparent;
    default:
      throw UnimplementedError();
  }
}

InputDecoration pickFieldStyle(
  BuildContext context, {
  required FieldVariant variant,
}) {
  return InputDecoration(
    filled: true,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
      borderSide: BorderSide(
        color: HSLColor.fromColor(_pickFillColor(context, variant))
            .withLightness(0.6)
            .toColor(),
        width: 2,
      ),
    ),
  );
}
