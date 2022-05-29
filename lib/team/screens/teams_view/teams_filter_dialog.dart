import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/app_widgets.dart';
import '../../../common/styles.dart';
import '../../../game/game.dart';
import '../../../game/game_providers.dart';
import '../../team_providers.dart';

class TeamsFilterDialog extends ConsumerWidget {
  const TeamsFilterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Header('Filtre'),
      content: _TeamsFilterContent(),
    );
  }
}

class _TeamsFilterContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(gamesProvider$).maybeWhen(
          orElse: () => const Loading(),
          data: (games) => SizedBox(
            width: MediaQuery.of(context).size.width,
            child: AppColumn(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.m,
              children: [
                _GameFilter(),
                _FreeSlotFilter(),
              ],
            ),
          ),
        );
  }
}

class _GameFilter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final games = ref.watch(gamesProvider$).value ?? [];
    final game = ref.watch(gameFilterProvider);

    void setGame(Game? game) {
      ref.read(gameFilterProvider.notifier).state = game;
    }

    void resetGame() {
      ref.refresh(gameFilterProvider);
    }

    return AppRow(
      spacing: AppSpacing.s,
      children: [
        const Expanded(
          child: AppText(
            'Joc',
            bold: true,
          ),
        ),
        Expanded(
          child: AppSelectField<Game>(
            items: games,
            value: game,
            onChanged: setGame,
            hint: 'Joc',
            displayMapper: (e) => AppText(
              e.name,
              overflow: TextOverflow.ellipsis,
            ),
            style: FieldStyle.naked,
          ),
          flex: 2,
        ),
        if (game != null)
          IconButton(
            onPressed: resetGame,
            icon: const Icon(Icons.cancel),
          ),
      ],
    );
  }
}

class _FreeSlotFilter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final freeSlot = ref.watch(freeSlotFilterProvider);

    void setFreeSlot(bool? freeSlot) {
      ref.read(freeSlotFilterProvider.notifier).state = freeSlot!;
    }

    return AppRow(
      children: [
        const Expanded(
          child: AppText(
            'Doar cu sloturi libere',
            bold: true,
          ),
        ),
        Expanded(
          child: RadioListTile<bool>(
            title: const Text('NU'),
            value: false,
            groupValue: freeSlot,
            onChanged: setFreeSlot,
          ),
        ),
        Expanded(
          child: RadioListTile<bool>(
            title: const Text('DA'),
            value: true,
            groupValue: freeSlot,
            onChanged: setFreeSlot,
          ),
        ),
      ],
    );
  }
}
