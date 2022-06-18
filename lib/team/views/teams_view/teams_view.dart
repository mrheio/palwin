import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles.dart';
import 'package:noctur/common/utils.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/game/providers.dart';
import 'package:noctur/team/logic/logic.dart';
import 'package:noctur/team/providers.dart';
import 'package:styles/styles.dart';

import '../../../game/logic/game.dart';
import 'team_card.dart';

class TeamsView extends ConsumerStatefulWidget {
  const TeamsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TeamsViewState();
  }
}

class _TeamsViewState extends ConsumerState<TeamsView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(teamsStateProvider.notifier).getTeams());
  }

  @override
  Widget build(BuildContext context) {
    final teamsState = ref.watch(teamsStateProvider);
    final status = teamsState.status;
    final teams = teamsState.teams;

    return StyledColumn(
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => _TeamsFilterDialog(),
            ),
            icon: const Icon(Icons.tune_rounded),
            iconSize: 32,
          ),
        ),
        Expanded(
          child: status is LoadingStatus
              ? const Loading()
              : teams.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      child: const StyledText(
                        'Nicio echipa gasita',
                        size: AppFontSize.h3,
                        semibold: true,
                      ),
                    )
                  : StyledList<Team>(
                      padding: const EdgeInsets.all(AppSpacing.m),
                      gap: AppSpacing.m,
                      items: teams,
                      displayBuilder: (team) => TeamCard(team),
                    ),
        ),
      ],
    );
  }
}

class _TeamsFilterDialog extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesState = ref.watch(gamesStateProvider);
    final gameFilter = ref.watch(gameFilterProvider);
    final gameFilterNotifier = ref.read(gameFilterProvider.notifier);
    final freeSlots = ref.watch(freeSlotsProvider);
    final freeSlotsNotifier = ref.read(freeSlotsProvider.notifier);

    return AlertDialog(
      backgroundColor: AppColor.bg,
      title: const StyledText('Filtre'),
      content: gamesState.status is LoadingStatus
          ? const Loading()
          : StyledColumn(
              mainAxisSize: MainAxisSize.min,
              children: [
                StyledRow(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(child: StyledText('Joc')),
                    Expanded(
                      flex: 2,
                      child: StyledRow(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: StyledSelectField<Game>(
                              value: gameFilter,
                              onChanged: (game) =>
                                  gameFilterNotifier.state = game,
                              items: gamesState.games,
                              displayMapper: (game) => StyledText(
                                game.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          if (gameFilter != null)
                            IconButton(
                              onPressed: () => gameFilterNotifier.state = null,
                              icon: const Icon(Icons.clear),
                              iconSize: 32,
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                StyledRow(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                        child: StyledText('Doar cu sloturi libere?')),
                    Expanded(
                      child: RadioListTile<bool>(
                        title: const StyledText('NU'),
                        value: false,
                        groupValue: freeSlots,
                        onChanged: (val) => freeSlotsNotifier.state = false,
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<bool>(
                        title: const StyledText('DA'),
                        value: true,
                        groupValue: freeSlots,
                        onChanged: (val) => freeSlotsNotifier.state = true,
                      ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
