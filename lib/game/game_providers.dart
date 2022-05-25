import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/game/game.dart';
import 'package:noctur/game/game_repository.dart';
import 'package:noctur/game/game_service.dart';
import 'package:noctur/team/team_providers.dart';

import '../common/database/firestore_service.dart';
import '../common/providers.dart';

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
