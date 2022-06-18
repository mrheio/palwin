import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/exceptions.dart';
import 'package:noctur/common/success.dart';
import 'package:noctur/common/utils.dart';
import 'package:noctur/game/logic/game.dart';
import 'package:noctur/game/logic/games_service.dart';

class AddGameSuccess extends SuccessStatus {
  const AddGameSuccess();
}

class DeleteGameSuccess extends SuccessStatus {
  DeleteGameSuccess(Game game) : super(Success('${game.name} sters'));
}

class GamesState {
  final List<Game> games;
  final AsyncStatus status;

  const GamesState(this.games, {this.status = const NormalStatus()});

  bool get hasGames => games.isNotEmpty;

  GamesState copyWith({List<Game>? games, AsyncStatus? status}) {
    return GamesState(games ?? this.games, status: status ?? this.status);
  }
}

class GamesNotifier extends StateNotifier<GamesState> {
  final GamesService _gamesService;
  StreamSubscription? _gamesSubscription;

  GamesNotifier(this._gamesService) : super(const GamesState([]));

  void getGames() {
    state = state.copyWith(status: const LoadingStatus());
    _gamesSubscription = _gamesService.getAllWithIcons$().listen((event) {
      state = state.copyWith(games: event, status: const NormalStatus());
    });
  }

  Future<void> addGame({
    required String name,
    required String teamSize,
    File? icon,
  }) async {
    state = state.copyWith(status: const LoadingStatus());
    try {
      await _gamesService.addFromForm(
          name: name, teamSize: teamSize, file: icon);
      state = state.copyWith(status: const AddGameSuccess());
    } on CustomException catch (error) {
      state = state.copyWith(status: FailStatus(error));
    }
  }

  Future<void> deleteGame(Game game) async {
    state = state.copyWith(status: const LoadingStatus());
    try {
      await _gamesService.deleteGame(game);
      state = state.copyWith(status: DeleteGameSuccess(game));
    } on CustomException catch (error) {
      state = state.copyWith(status: FailStatus(error));
    }
  }

  @override
  void dispose() {
    _gamesSubscription?.cancel();
    super.dispose();
  }
}
