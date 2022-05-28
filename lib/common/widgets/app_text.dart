import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String data;
  final bool bold;
  final Color? color;
  final EdgeInsetsGeometry margin;
  final double? fontSize;
  final TextOverflow? overflow;

  const AppText(
    this.data, {
    this.bold = false,
    this.color,
    this.margin = EdgeInsets.zero,
    this.fontSize,
    this.overflow,
    Key? key,
  }) : super(key: key);

  FontWeight _pickFontWeight() {
    if (bold) {
      return FontWeight.bold;
    }
    return FontWeight.normal;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Text(
        data,
        overflow: overflow,
        style: TextStyle(
          fontWeight: _pickFontWeight(),
          color: color,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
