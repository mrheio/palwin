import 'package:flutter/material.dart';

import '../styles.dart';

class AppCircleButton extends StatelessWidget {
  final Widget? child;
  final void Function()? onPressed;

  const AppCircleButton({
    this.child,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(14),
        primary: AppColor.primary[50],
      ),
    );
  }
}
