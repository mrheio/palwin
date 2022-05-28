import 'package:flutter/material.dart';

import '../styles.dart';

class Header extends StatelessWidget {
  final double size;
  final FontWeight weight;
  final String data;
  final EdgeInsetsGeometry margin;
  final Color? color;
  final TextOverflow? overflow;

  const Header(
    this.data, {
    this.size = AppFontSize.h3,
    this.weight = AppFontWeight.bold,
    this.margin = EdgeInsets.zero,
    this.color,
    this.overflow,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Text(
        data,
        overflow: overflow,
        style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color,
        ),
      ),
    );
  }
}
