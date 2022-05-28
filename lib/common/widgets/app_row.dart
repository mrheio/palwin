import 'package:flutter/material.dart';

import 'utils.dart';

class AppRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection? textDirection;
  final double? spacing;
  final EdgeInsetsGeometry margin;

  const AppRow({
    this.children = const [],
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.spacing,
    this.margin = EdgeInsets.zero,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        children:
            spacing != null ? spaceHorizontal(spacing!, children) : children,
      ),
    );
  }
}
