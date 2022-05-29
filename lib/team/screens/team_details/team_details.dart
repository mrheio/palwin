import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/team/team.dart';
import 'package:noctur/team/team_providers.dart';

import '../../../auth/auth_providers.dart';
import '../../../common/app_widgets.dart';
import '../../../common/styles.dart';
import 'chat.dart';
import 'team_details_aside.dart';

class TeamDetails extends ConsumerWidget {
  final String teamId;

  const TeamDetails({required this.teamId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(teamProvider$(teamId)).maybeWhen(
          orElse: () => const Loading(),
          data: (team) {
            if (team == null) {
              Navigator.of(context).pop();
              return const Loading();
            }
            return _TeamDetailsContent(team);
          },
        );
  }
}

class _TeamDetailsContent extends ConsumerWidget {
  final Team team;

  const _TeamDetailsContent(this.team);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider.select((value) => value.user!));

    return AppColumn(
      children: [
        SectionTitle(
          backgroundColor: AppColor.primary[90],
          child: Header(team.name),
        ),
        Expanded(
          child: PageView(
            children: [
              team.hasUser(user)
                  ? Chat(team)
                  : const Center(child: Header('Nu esti in echipa')),
              TeamDetailsAside(team),
            ],
          ),
        ),
      ],
    );
  }
}
