import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/auth_providers.dart';
import '../../../common/styles.dart';
import '../../../common/utils/ui_utils.dart';
import '../../../common/widgets/app_column.dart';
import '../../../common/widgets/header.dart';
import '../../../common/widgets/loading.dart';
import '../../../common/widgets/section_title.dart';
import 'chat.dart';
import 'team_details_aside.dart';
import 'team_details_state.dart';

class TeamDetails extends ConsumerWidget {
  final String teamId;

  const TeamDetails({required this.teamId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider.select((value) => value.user!));
    final loading = ref.watch(
        teamDetailsStateProvider(teamId).select((value) => value.loading));
    final team = ref
        .watch(teamDetailsStateProvider(teamId).select((value) => value.team));

    ref.listen<TeamDetailsState>(teamDetailsStateProvider(teamId),
        (previous, next) {
      final success = next.success;
      UiUtils.maybeShowSnackbar(context, success?.message);
      UiUtils.maybePop(context, success != null);
    });

    if (team == null || loading) {
      return const Loading(condition: true);
    }

    return AppColumn(
      children: [
        SectionTitle(
          backgroundColor: AppColor.primary[90],
          child: Header(
            team.name,
          ),
        ),
        Expanded(
          child: PageView(
            children: [
              team.hasUser(user)
                  ? Chat(teamId: teamId)
                  : const Center(
                      child: Header(
                        'Nu esti in echipa',
                      ),
                    ),
              TeamDetailsAside(teamId: teamId),
            ],
          ),
        ),
      ],
    );
  }
}
