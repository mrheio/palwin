import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/game/screens/games_view/games_view.dart';

import '../../../common/app_widgets.dart';
import '../../../common/styles.dart';
import '../../../common/utils/ui_utils.dart';
import '../../game.dart';
import '../../game_providers.dart';

class GamesList extends ConsumerWidget {
  const GamesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(gamesProvider$).maybeWhen(
          orElse: () => const Loading(),
          data: (games) {
            final gameSearch = ref.watch(gameSearchProvider);
            final filteredGames = games
                .where((element) => element.name
                    .toLowerCase()
                    .contains(gameSearch.toLowerCase()))
                .toList();
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: filteredGames.length,
                itemBuilder: (context, index) {
                  final game = filteredGames[index];
                  return _GameCard(game);
                },
              ),
            );
          },
        );
  }
}

class _GameCard extends ConsumerWidget {
  final Game game;

  const _GameCard(this.game);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> deleteGame() async {
      await ref.read(gameServiceProvider).deleteById(game.id);
      UiUtils.showSnackbar(context, '${game.name} sters');
    }

    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) => deleteGame(),
      child: AppCard(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: AppColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 12,
          children: [
            _GameCardTop(game),
            _GameCardBottom(game),
          ],
        ),
      ),
    );
  }
}

class _GameCardTop extends StatelessWidget {
  final Game game;

  const _GameCardTop(this.game);

  @override
  Widget build(BuildContext context) {
    return Header(
      game.name,
      size: AppFontSize.h3,
    );
  }
}

class _GameCardBottom extends StatelessWidget {
  final Game game;

  const _GameCardBottom(this.game);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          const WidgetSpan(
            child: AppText('Numar maxim jucatori in echipa:',
                margin: EdgeInsets.only(right: 4)),
          ),
          WidgetSpan(
            child: AppText(
              '${game.teamSize}',
              bold: true,
            ),
          ),
        ],
      ),
    );
  }
}
