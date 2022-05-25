import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/errors/err.dart';
import 'package:noctur/common/success.dart';
import 'package:noctur/game/game.dart';
import 'package:noctur/game/game_providers.dart';
import 'package:noctur/game/game_service.dart';
import 'package:optional/optional.dart';

class AddGameState {
  final TextEditingController nameField;
  final TextEditingController capacityField;
  final bool loading;
  final Err? error;
  final Success? success;

  AddGameState({
    TextEditingController? nameField,
    TextEditingController? capacityField,
    this.loading = false,
    this.error,
    this.success,
  })  : nameField = nameField ?? TextEditingController(),
        capacityField = capacityField ?? TextEditingController();

  void dispose() {
    nameField.dispose();
    capacityField.dispose();
  }

  AddGameState copyWith({
    bool? loading,
    Optional<Err>? error,
    Optional<Success>? success,
  }) {
    return AddGameState(
        nameField: nameField,
        capacityField: capacityField,
        loading: loading ?? this.loading,
        error: error != null ? error.orElseNull : this.error,
        success: success != null ? success.orElseNull : this.success);
  }
}

class AddGameStateNotifier extends StateNotifier<AddGameState> {
  final GameService _gameService;

  AddGameStateNotifier(this._gameService) : super(AddGameState());

  Future<void> addGame() async {
    state = state.copyWith(
        loading: true,
        error: const Optional.empty(),
        success: const Optional.empty());
    try {
      final name = state.nameField.text.trim();
      final capacity = state.capacityField.text.trim();
      final game = Game(name: name, capacity: int.parse(capacity));
      await _gameService.add(game);
      state = state.copyWith(
          loading: false,
          success: Optional.of(Success(message: '$name adaugat')));
    } on Err catch (error) {
      state = state.copyWith(
          loading: false,
          error: Optional.of(error),
          success: const Optional.empty());
    }
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}

final addGameStateNotifierProvider =
    StateNotifierProvider.autoDispose<AddGameStateNotifier, AddGameState>(
        (ref) {
  final gameService = ref.read(gameServiceProvider);
  return AddGameStateNotifier(gameService);
});
