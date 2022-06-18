import 'package:flutter/material.dart';
import 'package:palwin/common/styles/app_color.dart';

import '../../styles/app_spacing.dart';

final _borderRadius = BorderRadius.circular(24);

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
    return Container(
      padding: margin,
      child: Material(
        borderRadius: _borderRadius,
        color: AppColor.primary[80],
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 80),
          child: InkWell(
            onTap: onTap,
            borderRadius: _borderRadius,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.m,
                horizontal: AppSpacing.l,
              ),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
