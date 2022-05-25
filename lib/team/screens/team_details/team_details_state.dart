import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/team/team.dart';
import 'package:noctur/team/team_providers.dart';
import 'package:noctur/team/team_service.dart';

class TeamDetailsState {
  final Team? team;
  final bool loading;

  TeamDetailsState({this.team, this.loading = false});

  TeamDetailsState copyWith({Team? team, bool? loading}) {
    return TeamDetailsState(
      team: team ?? this.team,
      loading: loading ?? this.loading,
    );
  }
}

class TeamDetailsStateNotifier extends StateNotifier<TeamDetailsState> {
  final String teamId;
  final TeamService _teamService;
  StreamSubscription? _streamSub;

  TeamDetailsStateNotifier(this.teamId, this._teamService)
      : super(TeamDetailsState());

  void getData() {
    state = state.copyWith(loading: true);
    _streamSub = _teamService.getTeamWithUsers$(teamId).listen((event) {
      state = state.copyWith(team: event, loading: false);
    });
  }

  Future<void> joinTeam() async {
    await _teamService.addLoggedUserToTeam(state.team!);
  }

  Future<void> quitTeam() async {
    await _teamService.removeLoggedUserFromTeam(state.team!);
  }

  Future<void> deleteTeam() async {
    await _teamService.deleteById(state.team!.id);
  }

  @override
  void dispose() {
    _streamSub?.cancel();
    super.dispose();
  }
}

final teamDetailsStateProvider = StateNotifierProvider.family
    .autoDispose<TeamDetailsStateNotifier, TeamDetailsState, String>(
        (ref, teamId) {
  final teamService = ref.read(teamServiceProvider);
  return TeamDetailsStateNotifier(teamId, teamService)..getData();
});
