import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/providers.dart';
import 'package:noctur/common/utils/pages_controller.dart';
import 'package:noctur/game/logic/games_service.dart';
import 'package:noctur/game/logic/logic.dart';
import 'package:noctur/team/providers.dart';

final gamesRepositoryProvider = Provider((ref) {
  return ref.read(firestoreRepositoryFactoryProvider).getRepository<Game>();
});

final gamesServiceProvider = Provider((ref) {
  final repository = ref.read(gamesRepositoryProvider);
  final teamsService = ref.read(teamsServiceProvider);
  final storage = ref.read(firebaseStorageServiceProvider);
  return GamesService(repository, teamsService, storage);
});

final gamesProvider$ = StreamProvider.autoDispose((ref) {
  ref.maintainState = true;
  return ref.read(gamesServiceProvider).getAllWithIcons$();
});

final gamesPagesProvider = createPagesStateProvider();

final gameSearchProvider = StateProvider.autoDispose((ref) => '');
final searchingProvider = StateProvider.autoDispose((ref) => false);
