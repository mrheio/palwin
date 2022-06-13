import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary }

enum ButtonShape { rectangle, circle }

Color _pickColor(BuildContext context, ButtonVariant variant) {
  return variant == ButtonVariant.secondary
      ? Theme.of(context).colorScheme.secondary
      : Theme.of(context).colorScheme.primary;
}

OutlinedBorder _pickShape(ButtonShape shape) {
  return shape == ButtonShape.circle
      ? const CircleBorder()
      : RoundedRectangleBorder(borderRadius: BorderRadius.circular(4));
}

ButtonStyle pickButtonStyle(
  BuildContext context, {
  required ButtonVariant variant,
  required Size minSize,
  required ButtonShape shape,
  required bool outlined,
}) {
  if (outlined) {
    return OutlinedButton.styleFrom(
      primary: _pickColor(context, variant),
      side: BorderSide(
        color: _pickColor(context, variant),
        width: 3,
      ),
      minimumSize: minSize,
      shape: _pickShape(shape),
    );
  }

  return ElevatedButton.styleFrom(
    primary: _pickColor(context, variant),
    minimumSize: minSize,
    shape: _pickShape(shape),
  );
}
