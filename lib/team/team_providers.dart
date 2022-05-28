import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_providers.dart';
import '../common/database/firestore_service.dart';
import '../common/database/query_filters.dart';
import '../common/providers.dart';
import '../game/game.dart';
import '../game/game_providers.dart';
import '../user/user_providers.dart';
import 'team.dart';
import 'team_repository.dart';
import 'team_service.dart';

final teamDatabaseServiceProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  return FirestoreService<Team>(firestore, 'teams');
});

final teamRepositoryProvider = Provider((ref) {
  final databaseService = ref.read(teamDatabaseServiceProvider);
  return TeamRepository(databaseService);
});

final teamServiceProvider = Provider((ref) {
  final teamRepository = ref.read(teamRepositoryProvider);
  final gameRepository = ref.read(gameRepositoryProvider);
  final userRepository = ref.read(userRepositoryProvider);
  final authService = ref.read(authServiceProvider);
  return TeamService(
      teamRepository, gameRepository, userRepository, authService);
});

final gameFilterProvider = StateProvider<Game?>((ref) => null);
final freeSlotFilterProvider = StateProvider<bool>((ref) => false);

final teamsProvider$ = StreamProvider((ref) {
  final gameFilter = ref.watch(gameFilterProvider);
  final freeSlotFilter = ref.watch(freeSlotFilterProvider);
  var query = <QueryFilter>[];

  if (gameFilter != null) {
    query = [
      ...query,
      Where(
        key: 'gameId',
        condition: WhereCondition.equalsTo,
        value: gameFilter.id,
      )
    ];
  }

  if (freeSlotFilter) {
    query = [
      ...query,
      const Where(
        key: 'freeSlots',
        condition: WhereCondition.isGreaterThan,
        value: 0,
      )
    ];
  }

  final teamService = ref.read(teamServiceProvider);
  return teamService.getWhere$(query);
});
