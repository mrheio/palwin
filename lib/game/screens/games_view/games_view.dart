import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles.dart';
import 'package:noctur/common/utils/ui_utils.dart';
import 'package:noctur/common/widgets/app_column.dart';
import 'package:noctur/common/widgets/header.dart';
import 'package:noctur/game/game.dart';
import 'package:noctur/game/screens/games_view/games_view_state.dart';

import '../../../common/widgets/app_card.dart';
import '../../../common/widgets/loading.dart';

class GamesView extends ConsumerWidget {
  const GamesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(gamesViewStateNotifierProvider).loading;
    final games = ref.watch(gamesViewStateNotifierProvider).games;

    ref.listen<GamesViewState>(gamesViewStateNotifierProvider,
        (previous, next) {
      final success = next.success;
      if (success != null) {
        UiUtils.showSnackbar(context, success.message);
      }
    });

    return Loading(
      condition: loading,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            height: 16,
          ),
          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];
            return _GameCard(game);
          },
        ),
      ),
    );
  }
}

class _GameCard extends ConsumerWidget {
  final Game game;

  const _GameCard(this.game);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(gamesViewStateNotifierProvider.notifier);

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) => notifier.deleteGame(game),
      child: AppCard(
        child: AppColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            Header(
              game.name,
              size: AppFontSize.h3,
            ),
            Text('Numar maxim jucatori in echipa: ${game.capacity}'),
          ],
        ),
      ),
    );
  }
}
