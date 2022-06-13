import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  final String data;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final double? size;
  final Color? color;
  final EdgeInsets margin;
  final bool bold;
  final bool semibold;

  const StyledText(
    this.data, {
    this.overflow,
    this.textAlign,
    this.size,
    this.color,
    this.margin = EdgeInsets.zero,
    this.bold = false,
    this.semibold = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        data,
        textAlign: textAlign,
        overflow: overflow,
        style: const TextStyle().copyWith(
          fontSize: size,
          color: color,
          fontWeight: bold
              ? FontWeight.bold
              : semibold
                  ? FontWeight.w500
                  : FontWeight.normal,
        ),
      ),
    );
  }
}
