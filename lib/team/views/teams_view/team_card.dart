import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/common/styles/app_font_size.dart';
import 'package:noctur/common/widgets/blocks/app_card.dart';
import 'package:noctur/common/widgets/blocks/players.dart';
import 'package:noctur/game/logic/game.dart';
import 'package:noctur/team/logic/logic.dart';
import 'package:styles/styles.dart';

import '../../../common/styles/app_spacing.dart';

class TeamCard extends ConsumerWidget {
  final Team team;

  const TeamCard(this.team, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user!;

    return AppCard(
      onTap: () => GoRouter.of(context).go('/teams/${team.id}'),
      child: StyledColumn(
        gap: AppSpacing.m,
        children: [
          StyledRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: StyledText(
                  team.name,
                  size: AppFontSize.h3,
                  semibold: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              StyledText(
                Game.toName(team.gameId),
                size: AppFontSize.h5,
              ),
            ],
          ),
          StyledText(
            team.description,
            overflow: TextOverflow.ellipsis,
          ),
          StyledRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Players(filled: team.filledSlots, total: team.slots)),
              if (user.isInTeam(team)) const Icon(Icons.grade)
            ],
          ),
        ],
      ),
    );
  }
}
