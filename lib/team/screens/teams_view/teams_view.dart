import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles.dart';
import 'package:noctur/common/widgets/app_card.dart';
import 'package:noctur/common/widgets/app_column.dart';
import 'package:noctur/common/widgets/header.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/common/widgets/players.dart';
import 'package:noctur/team/screens/teams_view/teams_view_state.dart';
import 'package:noctur/team/team.dart';
import 'package:vrouter/vrouter.dart';

class TeamsView extends ConsumerWidget {
  const TeamsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teams = ref.watch(teamsViewStateNotifierProvider).teams;
    final loading = ref.watch(teamsViewStateNotifierProvider).loading;

    return Loading(
      condition: loading,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 16,
          ),
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
      onTap: () => VRouter.of(context).to('/tabs/teams/${team.id}'),
      child: AppColumn(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 12,
        children: [
          Header(
            team.name,
            size: AppFontSize.h4,
          ),
          Header(
            'Joc: ${team.game}',
            size: AppFontSize.h5,
          ),
          Players(
            filled: team.playersIds.length,
            total: team.capacity,
          )
        ],
      ),
    );
  }
}
