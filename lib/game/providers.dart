import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palwin/common/providers.dart';
import 'package:palwin/game/logic/logic.dart';
import 'package:palwin/team/providers.dart';

import '../common/utils.dart';

final gamesRepositoryProvider = Provider((ref) {
  return ref.read(firestoreRepositoryFactoryProvider).getRepository<Game>();
});

final gamesServiceProvider = Provider((ref) {
  final repository = ref.read(gamesRepositoryProvider);
  final teamsService = ref.read(teamsServiceProvider);
  final storage = ref.read(firebaseStorageServiceProvider);
  return GamesService(repository, teamsService, storage);
});

final gamesPagesProvider = createPagesStateProvider();

final gameSearchProvider = StateProvider.autoDispose((ref) => '');
final searchingProvider = StateProvider.autoDispose((ref) => false);

final gamesStateProvider =
    StateNotifierProvider.autoDispose<GamesNotifier, GamesState>((ref) {
  final gamesService = ref.read(gamesServiceProvider);
  return GamesNotifier(gamesService)..getGames();
});

final gamesEffectProvider =
    Provider.family.autoDispose((ref, BuildContext context) {
  ref.listen<GamesState>(gamesStateProvider, (previous, next) {
    final status = next.status;
    if (status is FailStatus) {
      StyledSnackbar.fromException(status.error).show(context);
    }
    if (status is AddGameSuccess) {
      ref.read(gamesPagesProvider).toInitPage();
    }
    if (status is DeleteGameSuccess) {
      StyledSnackbar.fromSuccess(status.success).show(context);
    }
  });
});
