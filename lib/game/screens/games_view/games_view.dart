import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles.dart';

import '../../../common/app_widgets.dart';
import '../../game_providers.dart';
import 'games_list.dart';

class GamesView extends ConsumerWidget {
  const GamesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppColumn(
      children: [
        _GamesViewTitle(),
        Expanded(child: GamesList()),
      ],
    );
  }
}

final searchOpenedProvider = StateProvider.autoDispose((ref) => false);

class _GamesViewTitle extends ConsumerWidget {
  const _GamesViewTitle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SectionTitle(
      child: AppRow(
        spacing: AppSpacing.l,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Header('Jocuri'),
          _GamesSearch(),
        ],
      ),
    );
  }
}

class _GamesSearch extends ConsumerWidget {
  const _GamesSearch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchOpened = ref.watch(searchOpenedProvider);

    void setSearchOpened(bool val) {
      ref.read(searchOpenedProvider.notifier).state = val;
    }

    if (searchOpened) {
      return const Expanded(child: _GamesSearchBar());
    }

    return IconButton(
      onPressed: () => setSearchOpened(true),
      icon: const Icon(Icons.search),
    );
  }
}

class _GamesSearchBar extends ConsumerWidget {
  const _GamesSearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void setSearchOpened(bool val) {
      ref.read(searchOpenedProvider.notifier).state = val;
    }

    void handleSearchChange(String val) {
      ref.read(gameSearchProvider.notifier).state = val;
    }

    return AppTextField(
      hint: 'Cauta joc',
      onChanged: handleSearchChange,
      suffixIcon: IconButton(
        onPressed: () => setSearchOpened(false),
        icon: const Icon(Icons.cancel),
      ),
    );
  }
}
