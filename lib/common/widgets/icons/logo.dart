import 'package:flutter/material.dart';

enum LogoSize { s, m, l }

class Logo extends StatelessWidget {
  final LogoSize size;

  const Logo({this.size = LogoSize.m, Key? key}) : super(key: key);

  double _pickSize() {
    if (size == LogoSize.s) {
      return 36;
    }
    if (size == LogoSize.l) {
      return 128;
    }
    return 180;
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/imgs/logos/logo.png',
      width: _pickSize(),
      filterQuality: FilterQuality.high,
    );
  }
}
