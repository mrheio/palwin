import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/team/team.dart';
import 'package:noctur/team/team_providers.dart';
import 'package:noctur/team/team_service.dart';

class TeamsViewState {
  final List<Team> teams;
  final bool loading;

  const TeamsViewState({this.teams = const [], this.loading = false});

  TeamsViewState copyWith({List<Team>? teams, bool? loading}) {
    return TeamsViewState(
        teams: teams ?? this.teams, loading: loading ?? this.loading);
  }
}

class TeamsViewStateNotifier extends StateNotifier<TeamsViewState> {
  final TeamService _teamService;
  StreamSubscription? _streamSub;

  TeamsViewStateNotifier(this._teamService) : super(const TeamsViewState());

  void getTeams() {
    state = state.copyWith(loading: true);
    _streamSub = _teamService.getAll$().listen((event) {
      state = state.copyWith(teams: event, loading: false);
    });
  }

  @override
  void dispose() {
    _streamSub?.cancel();
    super.dispose();
  }
}

final teamsViewStateNotifierProvider =
    StateNotifierProvider.autoDispose<TeamsViewStateNotifier, TeamsViewState>(
        (ref) {
  final teamService = ref.read(teamServiceProvider);
  return TeamsViewStateNotifier(teamService)..getTeams();
});
