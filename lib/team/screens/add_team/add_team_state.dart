import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/errors/err.dart';
import '../../../common/success.dart';
import '../../team.dart';
import '../../team_providers.dart';
import '../../team_service.dart';
import 'add_team_form_state.dart';

abstract class AddTeamState {
  const AddTeamState();
}

class AddTeamInit extends AddTeamState {
  const AddTeamInit();
}

class AddTeamLoading extends AddTeamState {
  const AddTeamLoading();
}

class AddTeamSuccess extends AddTeamState {
  final Success success;

  const AddTeamSuccess(this.success);
}

class AddTeamError extends AddTeamState {
  final Err error;

  const AddTeamError(this.error);
}

class AddTeamNotifier extends StateNotifier<AddTeamState> {
  final TeamService _teamService;
  final AddTeamFormState _formState;

  AddTeamNotifier(this._teamService, this._formState)
      : super(const AddTeamInit());

  Future<void> addTeam() async {
    state = const AddTeamLoading();
    try {
      final team = Team.fromForm(
        name: _formState.name,
        slots: _formState.slots,
        description: _formState.description,
        game: _formState.game!,
      );
      await _teamService.add(team);
      state = AddTeamSuccess(Success(message: '${team.name} adaugata'));
    } on Err catch (error) {
      state = AddTeamError(error);
    }
  }
}

final addTeamStateProvider =
    StateNotifierProvider.autoDispose<AddTeamNotifier, AddTeamState>((ref) {
  final teamService = ref.read(teamServiceProvider);
  final formState = ref.watch(addTeamFormStateProvider);
  return AddTeamNotifier(teamService, formState);
});
