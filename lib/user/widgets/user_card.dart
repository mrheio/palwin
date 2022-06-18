import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/team/providers.dart';
import 'package:noctur/team/views/teams_view/team_card.dart';
import 'package:styles/styles.dart';

import '../../common/styles.dart';
import '../../common/widgets/loading.dart';
import '../../common/widgets/widgets.dart';
import '../../team/logic/logic.dart';
import '../logic/logic.dart';

class UserCard extends ConsumerWidget {
  final Team? team;
  final SimpleUser user;

  const UserCard(this.team, this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggedUser =
        ref.watch(authStateProvider.select((value) => value.user))!;

    return AppCard(
      onTap: () => showDialog(
        context: context,
        builder: (context) => _UserTeamsDialog(user),
      ),
      child: StyledRow(
        gap: AppSpacing.s,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: StyledRow(
              crossAxisAlignment: CrossAxisAlignment.center,
              gap: AppSpacing.s,
              children: [
                if (team != null && team!.uid == user.id)
                  const Icon(Icons.diamond),
                StyledText(
                  user.username,
                  size: AppFontSize.h4,
                ),
              ],
            ),
          ),
          loggedUser.isFriendWith(user)
              ? IconButton(
                  onPressed: () => ref
                      .read(accountStateProvider.notifier)
                      .deleteFriend(user),
                  icon: const Icon(Icons.person_remove),
                )
              : IconButton(
                  onPressed: () => ref
                      .read(accountStateProvider.notifier)
                      .addFriend(Friend.fromSimpleUser(user)),
                  icon: const Icon(Icons.person_add),
                ),
        ],
      ),
    );
  }
}

final userTeamsProvider$ = StreamProvider.family((ref, SimpleUser user) {
  return ref.read(teamsServiceProvider).getWhere$(containsUser: user);
});

class _UserTeamsDialog extends ConsumerWidget {
  final SimpleUser user;

  const _UserTeamsDialog(this.user);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Echipe'),
      content: ref.watch(userTeamsProvider$(user)).maybeWhen(
            orElse: () => const Loading(),
            data: (data) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width * 0.75,
              child: StyledList<Team>(
                items: data,
                displayBuilder: (team) => TeamCard(team),
              ),
            ),
          ),
    );
  }
}
