import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palwin/common/exceptions.dart';
import 'package:palwin/common/utils.dart';
import 'package:palwin/team/logic/team.dart';
import 'package:palwin/team/logic/teams_service.dart';
import 'package:palwin/user/logic/logic.dart';

import '../../game/logic/logic.dart';

class AddTeamSuccess extends SuccessStatus {
  const AddTeamSuccess();
}

class TeamsState {
  final List<Team> teams;
  final AsyncStatus status;

  TeamsState(this.teams, {this.status = const NormalStatus()});

  TeamsState copyWith({List<Team>? teams, AsyncStatus? status}) {
    return TeamsState(teams ?? this.teams, status: status ?? this.status);
  }
}

class TeamsNotifier extends StateNotifier<TeamsState> {
  final TeamsService _teamsService;
  StreamSubscription? _teamsSubscription;

  TeamsNotifier(this._teamsService) : super(TeamsState([]));

  void getTeams({
    Game? game,
    bool freeSlots = false,
    SimpleUser? containsUser,
  }) {
    state = state.copyWith(status: const LoadingStatus());
    _teamsSubscription?.cancel();
    _teamsSubscription = _teamsService
        .getWhere$(game: game, freeSlots: freeSlots, containsUser: containsUser)
        .listen((event) {
      state = state.copyWith(teams: event, status: const NormalStatus());
    });
  }

  Future<void> addTeam({
    required String name,
    required String slots,
    required String description,
    required Game game,
    required SimpleUser user,
  }) async {
    state = state.copyWith(status: const LoadingStatus());
    try {
      await _teamsService.addFromForm(
          name: name,
          slots: slots,
          description: description,
          game: game,
          user: user);
      state = state.copyWith(status: const AddTeamSuccess());
    } on CustomException catch (error) {
      state = state.copyWith(status: FailStatus(error));
    }
  }

  @override
  void dispose() {
    _teamsSubscription?.cancel();
    super.dispose();
  }
}
