import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String data;
  final bool bold;
  final Color? color;
  final EdgeInsetsGeometry margin;
  final double? fontSize;

  const AppText(
    this.data, {
    this.bold = false,
    this.color,
    this.margin = EdgeInsets.zero,
    this.fontSize,
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
        style: TextStyle(
          fontWeight: _pickFontWeight(),
          color: color,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
