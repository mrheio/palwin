import 'package:flutter/material.dart';

List<Widget> _spaceChildren(List<Widget> children, double gap) {
  return children
      .expand((item) sync* {
        yield SizedBox(height: gap);
        yield item;
      })
      .skip(1)
      .toList();
}

class StyledColumn extends StatelessWidget {
  final List<Widget> children;
  final double? gap;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  const StyledColumn({
    this.children = const [],
    this.gap,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: gap != null ? _spaceChildren(children, gap!) : children,
    );
  }
}
