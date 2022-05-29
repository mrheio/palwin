import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/utils/ui_utils.dart';
import 'package:noctur/team/team.dart';
import 'package:noctur/team/team_providers.dart';

import '../../../auth/auth_providers.dart';
import '../../../common/app_widgets.dart';
import '../../../common/styles.dart';
import '../../../user/user.dart';

class TeamDetailsAside extends ConsumerWidget {
  final Team team;

  const TeamDetailsAside(this.team, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider.select((value) => value.user!));

    bool userOwnsTeam() => team.isOwnedBy(user);
    bool userCanQuit() => !team.isOwnedBy(user) && team.hasUser(user);
    bool userCanJoin() =>
        !team.isOwnedBy(user) && !team.hasUser(user) && !team.isFull();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
      child: AppColumn(
        spacing: 18,
        children: [
          Header(
            'Joc: ${team.game}',
            size: AppFontSize.h2,
          ),
          Expanded(
            child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: team.users.length,
                itemBuilder: (context, index) {
                  final player = team.users[index];
                  return _PlayerCard(player);
                },
              ),
            ),
          ),
          if (userOwnsTeam()) _DeleteTeamButton(team),
          if (userCanQuit()) _QuitTeamButton(team),
          if (userCanJoin()) _JoinTeamButton(team),
        ],
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

class _DeleteTeamButton extends ConsumerWidget {
  final Team team;

  const _DeleteTeamButton(this.team);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> deleteTeam() async {
      await ref.read(teamServiceProvider).deleteById(team.id);
      UiUtils.showSnackbar(context, 'Echipa ${team.name} stearsa');
    }

    return AppButton(
      onPressed: deleteTeam,
      child: const Text('STERGE ECHIPA'),
      fillWidth: true,
    );
  }
}

class _JoinTeamButton extends ConsumerWidget {
  final Team team;

  const _JoinTeamButton(this.team);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> joinTeam() async {
      await ref.read(teamServiceProvider).addLoggedUserToTeam(team);
    }

    return AppButton(
      onPressed: joinTeam,
      child: const Text('INTRA IN ECHIPA'),
      fillWidth: true,
    );
  }
}

class _QuitTeamButton extends ConsumerWidget {
  final Team team;

  const _QuitTeamButton(this.team);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> quitTeam() async {
      await ref.read(teamServiceProvider).removeLoggedUserFromTeam(team);
    }

    return AppButton(
      onPressed: quitTeam,
      child: const Text('IESI DIN ECHIPA'),
      fillWidth: true,
    );
  }
}
