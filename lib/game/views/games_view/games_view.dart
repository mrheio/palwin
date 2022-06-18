import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles/app_font_size.dart';
import 'package:noctur/common/styles/app_spacing.dart';
import 'package:noctur/common/utils/async_state.dart';
import 'package:noctur/game/logic/game.dart';
import 'package:noctur/game/providers.dart';
import 'package:styles/styles.dart';

import '../../../common/widgets/loading.dart';
import 'game_card.dart';

class GamesView extends ConsumerWidget {
  const GamesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gamesState = ref.watch(gamesStateProvider);

    if (gamesState.status is LoadingStatus) {
      return const Loading();
    }

    return StyledColumn(
      children: [
        _GameSearch(),
        Expanded(
          child: _GamesList(gamesState.games),
        ),
      ],
    );
  }
}

class _GameSearch extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searching = ref.watch(searchingProvider);

    void handleSearchCancel() {
      ref.refresh(gameSearchProvider);
      ref.refresh(searchingProvider);
    }

    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 80),
      child: Container(
        padding: const EdgeInsets.only(
            left: AppSpacing.m, right: AppSpacing.m, top: AppSpacing.s),
        child: StyledRow(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            searching
                ? Expanded(
                    child: StyledTextField(
                      onChanged: (val) =>
                          ref.read(gameSearchProvider.notifier).state = val,
                      suffixIcon: IconButton(
                        onPressed: handleSearchCancel,
                        icon: const Icon(Icons.cancel_outlined),
                      ),
                    ),
                  )
                : IconButton(
                    onPressed: () =>
                        ref.read(searchingProvider.notifier).state = true,
                    icon: const Icon(Icons.search),
                  )
          ],
        ),
      ),
    );
  }
}

class _GamesList extends ConsumerWidget {
  final List<Game> games;

  const _GamesList(this.games, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameSearch = ref.watch(gameSearchProvider);
    final filteredGames = games
        .where((element) =>
            element.name.toLowerCase().contains(gameSearch.toLowerCase()))
        .toList();

    return StyledList<Game>(
      padding: const EdgeInsets.all(AppSpacing.m),
      gap: AppSpacing.m,
      items: filteredGames,
      displayBuilder: (game) => GameCard(game),
      whenEmpty: const StyledText(
        'Niciun joc gasit',
        size: AppFontSize.h3,
        semibold: true,
      ),
    );
  }
}
