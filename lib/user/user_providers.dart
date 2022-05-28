import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/database/firestore_service.dart';
import '../common/providers.dart';
import 'user.dart';
import 'user_repository.dart';
import 'user_service.dart';

final userDatabaseServiceProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  return FirestoreService<User>(firestore, 'users');
});

final userRepositoryProvider = Provider((ref) {
  final databaseService = ref.read(userDatabaseServiceProvider);
  return UserRepository(databaseService);
});

final userServiceProvider = Provider((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return UserService(userRepository);
});
