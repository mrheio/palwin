import 'package:flutter/material.dart';

List<Widget> spaceHorizontal(double gap, Iterable<Widget> children) => children
    .expand((item) sync* {
      yield SizedBox(width: gap);
      yield item;
    })
    .skip(1)
    .toList();

List<Widget> spaceVertical(double gap, Iterable<Widget> children) => children
    .expand((item) sync* {
      yield SizedBox(height: gap);
      yield item;
    })
    .skip(1)
    .toList();
