import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyPlayerIcon extends StatelessWidget {
  const EmptyPlayerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/svgs/nofill_player.svg',
      color: Colors.white,
    );
  }
}
