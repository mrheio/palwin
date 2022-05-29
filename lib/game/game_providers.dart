import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/database/firestore_service.dart';
import '../common/providers.dart';
import '../team/team_providers.dart';
import 'game.dart';
import 'game_repository.dart';
import 'game_service.dart';

final gameDatabaseServiceProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  return FirestoreService<Game>(firestore, 'games');
});

final gameRepositoryProvider = Provider((ref) {
  final databaseService = ref.read(gameDatabaseServiceProvider);
  return GameRepository(databaseService);
});

final gameServiceProvider = Provider((ref) {
  final gameRepository = ref.read(gameRepositoryProvider);
  final teamRepository = ref.read(teamRepositoryProvider);
  return GameService(gameRepository, teamRepository);
});

final gamesProvider$ = StreamProvider.autoDispose<List<Game>>((ref) {
  return ref.read(gameServiceProvider).getAll$();
});

final gameSearchProvider = StateProvider.autoDispose((ref) => '');
