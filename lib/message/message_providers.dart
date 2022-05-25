import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/message/message.dart';
import 'package:noctur/message/message_repository.dart';
import 'package:noctur/message/message_service.dart';
import 'package:noctur/user/user_providers.dart';

import '../common/database/firestore_service.dart';
import '../common/providers.dart';

final messageDatabaseServiceProvider = Provider.family((ref, String teamId) {
  final firestore = ref.read(firestoreProvider);
  return FirestoreService<Message>(firestore, 'teams/$teamId/messages');
});

final messageRepositoryProvider = Provider.family((ref, String teamId) {
  final databaseService = ref.read(messageDatabaseServiceProvider(teamId));
  return MessageRepository(databaseService);
});

final messageServiceProvider = Provider.family((ref, String teamId) {
  final messageRepository = ref.read(messageRepositoryProvider(teamId));
  final userRepository = ref.read(userRepositoryProvider);
  return MessageService(messageRepository, userRepository);
});
