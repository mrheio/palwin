import 'package:flutter/material.dart';

import 'button_styles.dart';

class BaseButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final Size minSize;
  final ButtonShape shape;
  final bool outlined;

  const BaseButton({
    required this.child,
    this.onPressed,
    required this.variant,
    required this.minSize,
    required this.shape,
    required this.outlined,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = pickButtonStyle(
      context,
      variant: variant,
      minSize: minSize,
      shape: shape,
      outlined: outlined,
    );

    if (outlined) {
      return OutlinedButton(
        key: key,
        onPressed: onPressed,
        child: child,
        style: style,
      );
    }

    return ElevatedButton(
      key: key,
      onPressed: onPressed,
      child: child,
      style: style,
    );
  }
}
