import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/common/styles/app_font_size.dart';
import 'package:noctur/common/styles/app_spacing.dart';
import 'package:noctur/common/widgets/blocks/app_card.dart';
import 'package:noctur/team/logic/logic.dart';
import 'package:noctur/team/providers.dart';
import 'package:noctur/user/logic/logic.dart';
import 'package:styles/styles.dart';

class TeamDetailsView extends ConsumerWidget {
  final Team team;

  const TeamDetailsView(this.team, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider$).value!.value;

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
              displayBuilder: (user) => _UserCard(team, user),
            ),
          ),
          if (user.ownsTeam(team))
            StyledButtonFluid(
              onPressed: () => ref.read(teamsServiceProvider).deleteTeam(team),
              child: const Text('Sterge echipa'),
            ),
          if (!user.ownsTeam(team) && user.isInTeam(team))
            StyledButtonFluid(
              onPressed: () => ref.read(teamsServiceProvider).quitTeam(team),
              child: const Text('Iesi din echipa'),
            ),
          if (!user.isInTeam(team) && !team.isFull)
            StyledButtonFluid(
              onPressed: () => ref.read(teamsServiceProvider).joinTeam(team),
              child: const Text('Intra in echipa'),
            ),
        ],
      ),
    );
  }
}

class _UserCard extends ConsumerWidget {
  final Team team;
  final SimpleUser user;

  const _UserCard(this.team, this.user);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppCard(
      child: StyledRow(
        gap: AppSpacing.s,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (team.uid == user.id) const Icon(Icons.diamond),
          StyledText(
            user.username,
            size: AppFontSize.h4,
          ),
        ],
      ),
    );
  }
}
