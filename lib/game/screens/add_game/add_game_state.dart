import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/errors/err.dart';
import '../../../common/success.dart';
import '../../game.dart';
import '../../game_providers.dart';
import '../../game_service.dart';
import 'add_game_form_state.dart';

abstract class AddGameState {
  const AddGameState();
}

class AddGameInit extends AddGameState {
  const AddGameInit();
}

class AddGameLoading extends AddGameState {
  const AddGameLoading();
}

class AddGameSuccess extends AddGameState {
  final Success success;

  AddGameSuccess(String message) : success = Success(message: message);
}

class AddGameError extends AddGameState {
  final Err error;

  const AddGameError(this.error);
}

class AddGameStateNotifier extends StateNotifier<AddGameState> {
  final GameService _gameService;
  final AddGameFormState _formState;

  AddGameStateNotifier(this._gameService, this._formState)
      : super(const AddGameInit());

  Future<void> addGame() async {
    state = const AddGameLoading();
    final game = Game.fromForm(
      name: _formState.name,
      teamSize: _formState.teamSize,
    );
    try {
      await _gameService.add(game);
      state = AddGameSuccess('${game.name} adaugat');
    } on Err catch (error) {
      state = AddGameError(error);
    }
  }
}

final addGameStateProvider =
    StateNotifierProvider.autoDispose<AddGameStateNotifier, AddGameState>(
        (ref) {
  final gameService = ref.read(gameServiceProvider);
  final formState = ref.watch(addGameFormStateProvider);
  return AddGameStateNotifier(gameService, formState);
});
