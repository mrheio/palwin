import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/common/database/query_helpers.dart';
import 'package:noctur/common/providers.dart';
import 'package:noctur/common/utils/pages_controller.dart';
import 'package:noctur/team/logic/logic.dart';
import 'package:noctur/team/logic/message.dart';
import 'package:noctur/team/logic/teams_service.dart';
import 'package:noctur/user/logic/logic.dart';

import '../game/logic/game.dart';

final teamsRepositoryProvider = Provider((ref) {
  return ref.read(firestoreRepositoryFactoryProvider).getRepository<Team>();
});

final teamUsersRepositoryProvider = Provider.family((ref, String teamId) {
  return ref
      .read(firestoreRepositoryFactoryProvider)
      .fromDocument<Team>(teamId)
      .getRepository<SimpleUser>();
});

final teamMessagesRepositoryProvider = Provider.family((ref, String teamId) {
  return ref
      .read(firestoreRepositoryFactoryProvider)
      .fromDocument<Team>(teamId)
      .getRepository<Message>();
});

final teamsServiceProvider = Provider((ref) {
  final repository = ref.read(teamsRepositoryProvider);
  teamUsersRepository(String teamId) =>
      ref.read(teamUsersRepositoryProvider(teamId));
  teamMessagesRepository(String teamId) =>
      ref.read(teamMessagesRepositoryProvider(teamId));
  final authService = ref.read(authServiceProvider);
  return TeamsService(
      repository, teamUsersRepository, teamMessagesRepository, authService);
});

final teamsPagesProvider = Provider.autoDispose((ref) {
  final state = PagesState();
  ref.onDispose(() {
    state.dispose();
  });
  return state;
});

final gameFilterProvider = StateProvider.autoDispose<Game?>((ref) {
  ref.maintainState = true;
  return null;
});

final freeSlotsProvider = StateProvider.autoDispose<bool>((ref) {
  ref.maintainState = true;
  return false;
});

final teamsProvider$ = StreamProvider.autoDispose((ref) {
  final gameFilter = ref.watch(gameFilterProvider);
  final freeSlots = ref.watch(freeSlotsProvider);

  var queryFilter = QueryFilter();
  if (gameFilter != null) {
    queryFilter = queryFilter.equalsTo(key: 'gameId', value: gameFilter.id);
  }
  if (freeSlots) {
    queryFilter = queryFilter.isGreaterThan(key: 'freeSlots', value: 0);
  }

  return ref.read(teamsRepositoryProvider).getWhere$(queryFilter);
});

final teamProvider$ = StreamProvider.family.autoDispose((ref, String id) {
  return ref.read(teamsServiceProvider).getById$(id);
});

final teamMessagesProvider$ = StreamProvider.family
    .autoDispose<List<Message>, String>((ref, teamId) async* {
  final team = await ref.watch(teamProvider$(teamId).future);
  if (!team.isPresent) {
    yield <Message>[];
    return;
  }
  yield* ref
      .read(teamMessagesRepositoryProvider(team.value.id))
      .getWhere$(QueryFilter().orderDesc('createdAt'));
});
