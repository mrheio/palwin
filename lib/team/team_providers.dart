import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/database/firestore_service.dart';
import 'package:noctur/team/team.dart';
import 'package:noctur/team/team_repository.dart';
import 'package:noctur/team/team_service.dart';

import '../common/providers.dart';

final teamDatabaseServiceProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  return FirestoreService<Team>(firestore, 'teams');
});

final teamRepositoryProvider = Provider((ref) {
  final databaseService = ref.read(teamDatabaseServiceProvider);
  return TeamRepository(databaseService);
});

final userServiceProvider = Provider((ref) {
  final teamRepository = ref.read(teamRepositoryProvider);
  return TeamService(teamRepository);
});
