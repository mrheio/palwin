import 'package:flutter/material.dart';
import 'package:noctur/common/styles.dart';

class Header extends StatelessWidget {
  final double size;
  final FontWeight weight;
  final String data;
  final EdgeInsetsGeometry margin;
  final Color? color;

  const Header(
    this.data, {
    this.size = AppFontSize.h3,
    this.weight = AppFontWeight.bold,
    this.margin = EdgeInsets.zero,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Text(
        data,
        style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color,
        ),
      ),
    );
  }
}
