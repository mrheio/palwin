import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/auth_providers.dart';
import 'package:noctur/common/styles.dart';
import 'package:noctur/common/widgets/app_button.dart';
import 'package:noctur/common/widgets/app_card.dart';
import 'package:noctur/common/widgets/app_column.dart';
import 'package:noctur/common/widgets/header.dart';
import 'package:noctur/team/screens/team_details/team_details_state.dart';
import 'package:noctur/user/user.dart';

import '../../../common/widgets/loading.dart';

class TeamDetailsAside extends ConsumerWidget {
  final String teamId;

  const TeamDetailsAside({required this.teamId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateNotifierProvider).user!;
    final state = ref.watch(teamDetailsStateProvider(teamId));
    final notifier = ref.read(teamDetailsStateProvider(teamId).notifier);
    final loading = state.loading;
    final team = state.team;

    if (team == null) {
      return const Loading(condition: true);
    }

    return Loading(
      condition: loading,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
        child: AppColumn(
          spacing: 18,
          children: [
            Header(
              'Joc: ${team.game}',
              size: AppFontSize.h2,
            ),
            const Header(
              'Players',
              size: AppFontSize.h2,
            ),
            Expanded(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemCount: team.users.length,
                  itemBuilder: (context, index) {
                    final player = team.users[index];
                    return _PlayerCard(player);
                  },
                ),
              ),
            ),
            if (team.isOwnedBy(user))
              AppButton(
                onPressed: () {},
                child: const Text('Sterge echipa'),
                fillWidth: true,
              ),
            if (!team.isOwnedBy(user) && team.hasUser(user))
              AppButton(
                onPressed: notifier.quitTeam,
                child: const Text('Iesi din echipa'),
                fillWidth: true,
              ),
            if (!team.isOwnedBy(user) && !team.hasUser(user) && !team.isFull())
              AppButton(
                onPressed: notifier.joinTeam,
                child: const Text('Intra in echipa'),
                fillWidth: true,
              )
          ],
        ),
      ),
    );
  }
}

class _PlayerCard extends StatelessWidget {
  final User player;

  const _PlayerCard(this.player);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Center(
        child: Header(
          player.username,
          size: AppFontSize.h4,
        ),
      ),
    );
  }
}
