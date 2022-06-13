import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  final String label;

  const FieldLabel(this.label, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label);
  }
}
