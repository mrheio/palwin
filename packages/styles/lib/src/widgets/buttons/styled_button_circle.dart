import 'dart:ui';

import 'package:flutter/material.dart';

import 'base_button.dart';
import 'button_styles.dart';

class StyledButtonCircle extends BaseButton {
  const StyledButtonCircle({
    required Widget child,
    VoidCallback? onPressed,
    ButtonVariant variant = ButtonVariant.primary,
    bool outlined = false,
    Key? key,
  }) : super(
          key: key,
          child: child,
          onPressed: onPressed,
          variant: variant,
          minSize: const Size.square(56),
          shape: ButtonShape.circle,
          outlined: outlined,
        );
}
