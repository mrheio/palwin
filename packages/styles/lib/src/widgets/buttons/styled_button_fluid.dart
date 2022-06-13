import 'dart:ui';

import 'package:flutter/material.dart';

import 'base_button.dart';
import 'button_styles.dart';

class StyledButtonFluid extends BaseButton {
  const StyledButtonFluid({
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
          minSize: const Size.fromHeight(50),
          shape: ButtonShape.rectangle,
          outlined: outlined,
        );
}
