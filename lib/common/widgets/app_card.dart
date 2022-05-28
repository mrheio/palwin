import 'package:flutter/material.dart';

import '../styles.dart';

class AppCard extends StatelessWidget {
  final Widget? child;
  final void Function()? onTap;
  final EdgeInsetsGeometry margin;

  const AppCard({
    this.child,
    this.onTap,
    this.margin = EdgeInsets.zero,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Material(
        color: AppColor.primary[80],
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
