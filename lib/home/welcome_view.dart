import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:styles/styles.dart';

import '../common/styles.dart';

class WelcomeView extends ConsumerWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      child: StyledColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        gap: AppSpacing.l,
        children: [
          const StyledText(
            'Bine ai venit!',
            size: AppFontSize.h1,
            semibold: true,
          ),
          SvgPicture.asset(
            'assets/svgs/welcome_video_games.svg',
            width: 240,
            height: 240,
          ),
          StyledButtonFluid(
            onPressed: () => GoRouter.of(context).push('/entry'),
            child: const StyledText('Autentificare'),
          ),
        ],
      ),
    );
  }
}
