import 'package:flutter/material.dart';

import '../icons/empty_player_icon.dart';
import '../icons/filled_player_icon.dart';

class Players extends StatelessWidget {
  final int filled;
  final int total;

  const Players({required this.filled, required this.total, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (int i = 0; i < filled; i++) const FilledPlayerIcon(),
        for (int i = 0; i < total - filled; i++) const EmptyPlayerIcon(),
      ],
    );
  }
}
