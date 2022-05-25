import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/auth_providers.dart';
import 'package:noctur/common/database/firestore_service.dart';
import 'package:noctur/game/game_providers.dart';
import 'package:noctur/team/team.dart';
import 'package:noctur/team/team_repository.dart';
import 'package:noctur/team/team_service.dart';
import 'package:noctur/user/user_providers.dart';

import '../common/providers.dart';

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
