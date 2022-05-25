import 'package:flutter/material.dart';
import 'package:noctur/common/widgets/empty_player_icon.dart';
import 'package:noctur/common/widgets/filled_player_icon.dart';

class Players extends StatelessWidget {
  final int filled;
  final int total;

  const Players({required this.filled, required this.total, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        for (int i = 0; i < filled; i++) const FilledPlayerIcon(),
        for (int i = 0; i < total - filled; i++) const EmptyPlayerIcon(),
      ],
    );
  }
}
