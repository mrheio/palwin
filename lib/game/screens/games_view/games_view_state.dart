import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/game/game.dart';
import 'package:noctur/game/game_service.dart';
import 'package:optional/optional.dart';

import '../../../common/success.dart';
import '../../game_providers.dart';

class GamesViewState {
  final List<Game> games;
  final bool loading;
  final Success? success;

  const GamesViewState({
    this.games = const [],
    this.loading = false,
    this.success,
  });

  GamesViewState copyWith({
    List<Game>? games,
    bool? loading,
    Optional<Success>? success,
  }) {
    return GamesViewState(
      games: games ?? this.games,
      loading: loading ?? this.loading,
      success: success != null ? success.orElseNull : this.success,
    );
  }
}

class GamesViewStateNotifier extends StateNotifier<GamesViewState> {
  final GameService _gameService;
  StreamSubscription? _streamSub;

  GamesViewStateNotifier(this._gameService) : super(const GamesViewState());

  void getGames() {
    state = state.copyWith(loading: true);
    _streamSub = _gameService.getAll$().listen((event) {
      state = state.copyWith(
          games: event, loading: false, success: const Optional.empty());
    });
  }

  Future<void> deleteGame(Game game) async {
    state = state.copyWith(loading: false);
    await _gameService.deleteById(game.id);
    state = state.copyWith(
        success: Optional.of(Success(message: '${game.name} sters')));
  }

  @override
  void dispose() {
    _streamSub?.cancel();
    super.dispose();
  }
}

final gamesViewStateNotifierProvider =
    StateNotifierProvider.autoDispose<GamesViewStateNotifier, GamesViewState>(
        (ref) {
  final gameService = ref.read(gameServiceProvider);
  return GamesViewStateNotifier(gameService)..getGames();
});
