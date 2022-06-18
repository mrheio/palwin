import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:noctur/common/styles.dart';
import 'package:noctur/common/utils.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/team/providers.dart';
import 'package:styles/styles.dart';
import 'package:super_rich_text/super_rich_text.dart';

import '../acccount/providers.dart';
import '../team/logic/team.dart';
import '../team/views/teams_view/team_card.dart';
import '../user/logic/complex_user.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    if (authState.status is LoadingStatus) {
      return const Loading();
    }

    if (authState.hasUser) {
      return _MainView(authState.user!);
    }

    return _WelcomeView();
  }
}

final userTeamsProvider$ = StreamProvider.autoDispose<List<Team>>((ref) {
  final user = ref.watch(authStateProvider.select((value) => value.user))!;
  return ref.read(teamsServiceProvider).getWhere$(containsUser: user);
});

class _MainView extends ConsumerWidget {
  final ComplexUser user;

  const _MainView(this.user);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userTeamsProvider$).maybeWhen(
          orElse: () => const Loading(),
          data: (data) => SafeArea(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.m),
              child: StyledColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                gap: AppSpacing.l,
                children: [
                  SuperRichText(
                    text: 'Bine ai venit, *${user.username}*',
                    style: const TextStyle(fontSize: AppFontSize.h2),
                  ),
                  Expanded(
                    child: StyledColumn(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SuperRichText(
                          text: '*Echipele tale*',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: AppFontSize.h4,
                          ),
                        ),
                        Expanded(
                          child: StyledList<Team>(
                            padding: const EdgeInsets.all(AppSpacing.m),
                            gap: AppSpacing.m,
                            items: data,
                            displayBuilder: (team) => TeamCard(team),
                            whenEmpty: StyledColumn(
                              gap: AppSpacing.m,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SuperRichText(
                                  text: '*Nu esti in nicio echipa*.',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: AppFontSize.h3,
                                  ),
                                ),
                                SuperRichText(
                                  text:
                                      'Du-te pe tabul de *echipe* si alatura-te cuiva.',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: AppFontSize.h5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}

class _WelcomeView extends ConsumerWidget {
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
            onPressed: () => GoRouter.of(context).go('/entry'),
            child: const StyledText('Autentificare'),
          ),
        ],
      ),
    );
  }
}
