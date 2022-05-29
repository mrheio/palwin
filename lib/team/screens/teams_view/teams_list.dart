import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrouter/vrouter.dart';

import '../../../common/app_widgets.dart';
import '../../../common/styles.dart';
import '../../team.dart';
import '../../team_providers.dart';

class TeamsList extends ConsumerWidget {
  const TeamsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(teamsProvider$).maybeWhen(
          orElse: () => const Loading(),
          data: (teams) => MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return _TeamCard(team);
              },
            ),
          ),
        );
  }
}

class _TeamCard extends ConsumerWidget {
  final Team team;

  const _TeamCard(this.team);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppCard(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      onTap: () => VRouter.of(context).to('/tabs/teams/${team.id}'),
      child: AppColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.m,
        children: [
          Header(
            team.name,
            size: AppFontSize.h4,
            overflow: TextOverflow.ellipsis,
          ),
          Header(
            'Joc: ${team.game}',
            size: AppFontSize.h5,
          ),
          Players(
            filled: team.filledSlots,
            total: team.slots,
          )
        ],
      ),
    );
  }
}
