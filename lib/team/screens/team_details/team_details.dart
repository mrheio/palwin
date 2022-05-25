import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles.dart';
import 'package:noctur/common/widgets/app_column.dart';
import 'package:noctur/common/widgets/header.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/team/screens/team_details/chat.dart';
import 'package:noctur/team/screens/team_details/team_details_aside.dart';
import 'package:noctur/team/screens/team_details/team_details_state.dart';

import '../../../auth/auth_providers.dart';

class TeamDetails extends ConsumerWidget {
  final String teamId;

  TeamDetails({required this.teamId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateNotifierProvider).user!;
    final teamDetailsState = ref.watch(teamDetailsStateProvider(teamId));
    final loading = teamDetailsState.loading;
    final team = teamDetailsState.team;

    if (team == null || loading) {
      return const Loading(condition: true);
    }

    return AppColumn(
      children: [
        SizedBox.fromSize(
          size: const Size.fromHeight(80),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: AlignmentDirectional.centerStart,
            color: AppColor.primary[90],
            child: Header(
              team.name,
              size: AppFontSize.h3,
            ),
          ),
        ),
        Expanded(
          child: PageView(
            children: [
              team.hasUser(user)
                  ? Chat(teamId: teamId)
                  : const Center(
                      child: Header('Nu esti in echipa'),
                    ),
              TeamDetailsAside(teamId: teamId),
            ],
          ),
        ),
      ],
    );
  }
}
