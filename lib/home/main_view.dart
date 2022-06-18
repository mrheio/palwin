import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/common/utils/async_state.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/team/providers.dart';
import 'package:styles/styles.dart';
import 'package:super_rich_text/super_rich_text.dart';

import '../common/styles.dart';
import '../team/logic/logic.dart';
import '../team/views/teams_view/team_card.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MainState();
  }
}

class _MainState extends ConsumerState<MainView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(teamsStateProvider.notifier)
        .getTeams(containsUser: ref.read(authStateProvider).user));
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authStateProvider).user!;
    final teamsState = ref.watch(teamsStateProvider);

    if (teamsState.status is LoadingStatus) {
      return const Loading();
    }

    return SafeArea(
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
                gap: AppSpacing.m,
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
                      gap: AppSpacing.m,
                      items: teamsState.teams,
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
    );
  }
}
