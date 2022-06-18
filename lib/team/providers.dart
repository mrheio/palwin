import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palwin/common/providers.dart';
import 'package:palwin/common/utils.dart';
import 'package:palwin/team/logic/logic.dart';

import '../game/logic/game.dart';
import '../user/logic/simple_user.dart';

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
  return TeamsService(repository, teamUsersRepository, teamMessagesRepository);
});

final teamsPagesProvider = createPagesStateProvider();

final gameFilterProvider = StateProvider.autoDispose<Game?>((ref) {
  ref.maintainState = true;
  return null;
});

final freeSlotsProvider = StateProvider.autoDispose<bool>((ref) {
  ref.maintainState = true;
  return false;
});

final containsUserProvider =
    StateProvider.autoDispose<SimpleUser?>((ref) => null);

final teamsStateProvider =
    StateNotifierProvider.autoDispose<TeamsNotifier, TeamsState>((ref) {
  final teamsService = ref.read(teamsServiceProvider);
  final game = ref.watch(gameFilterProvider);
  final freeSlots = ref.watch(freeSlotsProvider);
  return TeamsNotifier(teamsService)
    ..getTeams(game: game, freeSlots: freeSlots);
});

final teamsEffectProvider =
    Provider.family.autoDispose((ref, BuildContext context) {
  ref.listen<TeamsState>(teamsStateProvider, (previous, next) {
    final status = next.status;
    if (status is FailStatus) {
      StyledSnackbar.fromException(status.error).show(context);
    }
    if (status is AddTeamSuccess) {
      ref.read(teamsPagesProvider).toInitPage();
    }
  });
});

final teamProvider$ = StreamProvider.family.autoDispose((ref, String id) {
  return ref.read(teamsServiceProvider).getById$(id);
});
