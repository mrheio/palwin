import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optional/optional.dart';

import '../../../common/success.dart';
import '../../team.dart';
import '../../team_providers.dart';
import '../../team_service.dart';

class TeamDetailsState {
  final Team? team;
  final bool loading;
  final Success? success;

  TeamDetailsState({this.team, this.loading = false, this.success});

  TeamDetailsState copyWith(
      {Team? team, bool? loading, Optional<Success>? success}) {
    return TeamDetailsState(
      team: team ?? this.team,
      loading: loading ?? this.loading,
      success: success != null ? success.orElseNull : this.success,
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
    state = state.copyWith(
        success: Optional.of(Success(message: '${state.team!.name} stearsa')));
    state = state.copyWith(success: const Optional.empty());
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
