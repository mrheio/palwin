import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/database/firestore_service.dart';
import 'package:noctur/common/providers.dart';
import 'package:noctur/user/user.dart';
import 'package:noctur/user/user_repository.dart';
import 'package:noctur/user/user_service.dart';

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
