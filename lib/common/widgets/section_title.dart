import 'package:flutter/material.dart';

import '../styles.dart';

class SectionTitle extends StatelessWidget {
  final Widget? child;
  final double titleSize;
  final Color? backgroundColor;

  const SectionTitle({
    this.child,
    this.titleSize = AppFontSize.h2,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 100,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: AlignmentDirectional.centerStart,
        color: backgroundColor,
        child: child,
      ),
    );
  }
}
