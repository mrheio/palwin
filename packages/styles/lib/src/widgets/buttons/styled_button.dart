import 'package:flutter/material.dart';

import 'base_button.dart';
import 'button_styles.dart';

class StyledButton extends BaseButton {
  const StyledButton({
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
          minSize: const Size(120, 50),
          shape: ButtonShape.rectangle,
          outlined: outlined,
        );
}
