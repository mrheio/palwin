import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/common/styles.dart';
import 'package:noctur/team/logic/logic.dart';
import 'package:noctur/team/providers.dart';
import 'package:noctur/user/logic/logic.dart';
import 'package:styles/styles.dart';

import '../../../user/widgets/user_card.dart';

class TeamDetailsView extends ConsumerWidget {
  final Team team;

  const TeamDetailsView(this.team, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user!;

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.m, vertical: AppSpacing.l),
      child: StyledColumn(
        gap: AppSpacing.m,
        children: [
          Container(
            alignment: Alignment.center,
            child: const StyledText(
              'Jucatori in echipa',
              size: AppFontSize.h3,
              semibold: true,
            ),
          ),
          Expanded(
            child: StyledList<SimpleUser>(
              items: team.users,
              gap: AppSpacing.s,
              displayBuilder: (user) => UserCard(team, user),
            ),
          ),
          if (user.ownsTeam(team))
            StyledButtonFluid(
              onPressed: () => ref.read(teamsServiceProvider).deleteTeam(team),
              child: const Text('Sterge echipa'),
            ),
          if (!user.ownsTeam(team) && user.isInTeam(team))
            StyledButtonFluid(
              onPressed: () =>
                  ref.read(teamsServiceProvider).deleteMember(user, team),
              child: const Text('Iesi din echipa'),
            ),
          if (!user.isInTeam(team) && !team.isFull)
            StyledButtonFluid(
              onPressed: () =>
                  ref.read(teamsServiceProvider).addMember(user, team),
              child: const Text('Intra in echipa'),
            ),
        ],
      ),
    );
  }
}
