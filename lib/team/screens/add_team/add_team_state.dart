import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/errors/err.dart';
import 'package:noctur/common/success.dart';
import 'package:noctur/game/game.dart';
import 'package:noctur/game/game_providers.dart';
import 'package:noctur/game/game_service.dart';
import 'package:noctur/team/team.dart';
import 'package:noctur/team/team_providers.dart';
import 'package:noctur/team/team_service.dart';
import 'package:optional/optional.dart';

class AddTeamState {
  final TextEditingController nameField;
  final TextEditingController capacityField;
  final TextEditingController descriptionField;
  final List<Game> games;
  final Game? game;
  final bool loading;
  final Err? error;
  final Success? success;

  AddTeamState({
    TextEditingController? nameField,
    TextEditingController? capacityField,
    TextEditingController? descriptionField,
    this.games = const [],
    this.game,
    this.loading = false,
    this.error,
    this.success,
  })  : nameField = nameField ?? TextEditingController(),
        capacityField = capacityField ?? TextEditingController(),
        descriptionField = descriptionField ?? TextEditingController();

  void dispose() {
    nameField.dispose();
    capacityField.dispose();
    descriptionField.dispose();
  }

  AddTeamState copyWith({
    List<Game>? games,
    Optional<Game>? game,
    bool? loading,
    Optional<Err>? error,
    Optional<Success>? success,
  }) {
    return AddTeamState(
      nameField: nameField,
      capacityField: capacityField,
      descriptionField: descriptionField,
      games: games ?? this.games,
      game: game != null ? game.orElseNull : this.game,
      loading: loading ?? this.loading,
      error: error != null ? error.orElseNull : this.error,
      success: success != null ? success.orElseNull : this.success,
    );
  }
}

class AddTeamStateNotifier extends StateNotifier<AddTeamState> {
  final TeamService _teamService;
  final GameService _gameService;
  StreamSubscription? _streamSub;

  AddTeamStateNotifier(this._teamService, this._gameService)
      : super(AddTeamState());

  void setGame(Game? game) {
    state = state.copyWith(game: Optional.ofNullable(game));
  }

  void getGames() {
    state = state.copyWith(loading: true);
    _streamSub = _gameService.getAll$().listen((event) {
      state = state.copyWith(loading: false, games: event);
    });
  }

  Future<void> addTeam() async {
    state = state.copyWith(
        loading: true,
        error: const Optional.empty(),
        success: const Optional.empty());
    try {
      final name = state.nameField.text.trim();
      final capacity = state.capacityField.text.trim();
      final description = state.descriptionField.text.trim();
      final game = state.game;
      final team = Team.fromForm(
          name: name,
          capacity: capacity,
          description: description,
          game: game!);
      await _teamService.add(team);
      state = state.copyWith(
          loading: false,
          success: Optional.of(Success(message: '$name adaugata')));
    } on Err catch (error) {
      state = state.copyWith(loading: false, error: Optional.of(error));
    }
  }

  @override
  void dispose() {
    _streamSub?.cancel();
    state.dispose();
    super.dispose();
  }
}

final addTeamStateNotifierProvider =
    StateNotifierProvider.autoDispose<AddTeamStateNotifier, AddTeamState>(
        (ref) {
  final teamService = ref.read(teamServiceProvider);
  final gameService = ref.read(gameServiceProvider);
  return AddTeamStateNotifier(teamService, gameService)..getGames();
});
