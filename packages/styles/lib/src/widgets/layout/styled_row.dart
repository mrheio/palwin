import 'package:flutter/material.dart';

List<Widget> _spaceChildren(List<Widget> children, double gap) {
  return children
      .expand((item) sync* {
        yield SizedBox(width: gap);
        yield item;
      })
      .skip(1)
      .toList();
}

class StyledRow extends StatelessWidget {
  final List<Widget> children;
  final double? gap;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const StyledRow({
    this.children = const [],
    this.gap,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      key: key,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: gap != null ? _spaceChildren(children, gap!) : children,
    );
  }
}
