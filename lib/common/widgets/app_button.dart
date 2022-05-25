import 'package:flutter/material.dart';
import 'package:noctur/common/styles.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget? child;
  final EdgeInsetsGeometry margin;
  final bool fillWidth;

  const AppButton({
    required this.onPressed,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.fillWidth = false,
    Key? key,
  }) : super(key: key);

  Size _pickMinimumSize() {
    return fillWidth ? const Size.fromHeight(50) : const Size(160, 50);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          primary: AppColor.primary[50],
          minimumSize: _pickMinimumSize(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),
    );
  }
}
