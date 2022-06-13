import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/app_utils.dart';
import 'package:noctur/common/exceptions/custom_exception.dart';
import 'package:noctur/common/success.dart';
import 'package:noctur/common/utils/disposable_state.dart';
import 'package:noctur/game/logic/game.dart';
import 'package:noctur/team/logic/teams_service.dart';
import 'package:noctur/team/providers.dart';
import 'package:optional/optional.dart';

import '../../../common/utils/ui_utils.dart';

class AddTeamState implements DisposableState {
  final TextEditingController nameController;
  final TextEditingController slotsController;
  final TextEditingController descriptionController;
  final Game? game;
  final bool loading;
  final Optional<Success> success;
  final Optional<CustomException> error;

  AddTeamState({
    AddTeamState? prev,
    Optional<Game>? maybeGame,
    this.loading = false,
    this.success = const Optional.empty(),
    this.error = const Optional.empty(),
  })  : nameController = createTextEditingController(prev?.nameController),
        slotsController = createTextEditingController(prev?.slotsController),
        descriptionController =
            createTextEditingController(prev?.descriptionController),
        game = maybeGame != null ? maybeGame.orElseNull : prev?.game;

  String get name => nameController.text.trim();
  String get slots => slotsController.text.trim();
  String get description => descriptionController.text.trim();

  @override
  void onDispose() {
    nameController.dispose();
    slotsController.dispose();
    descriptionController.dispose();
  }

  AddTeamState copyWith({
    Optional<Game>? maybeGame,
    bool? loading,
    Success? success,
    CustomException? error,
  }) {
    return AddTeamState(
      prev: this,
      maybeGame: maybeGame,
      loading: loading ?? false,
      success: Optional.ofNullable(success),
      error: Optional.ofNullable(error),
    );
  }
}

class AddTeamNotifier extends DisposableStateNotifier<AddTeamState> {
  final TeamsService _teamsService;

  AddTeamNotifier(this._teamsService) : super(AddTeamState());

  void setGame(Game? game) {
    if (game != null) {
      state = state.copyWith(maybeGame: Optional.of(game));
    }
  }

  Future<void> addTeam() async {
    state = state.copyWith(loading: true);
    try {
      await _teamsService.addFromForm(
        name: state.name,
        slots: state.slots,
        description: state.description,
        game: state.game!,
      );
      state = state.copyWith(success: Success.empty);
    } on CustomException catch (error) {
      state = state.copyWith(error: error);
    }
  }
}

final addTeamStateProvider =
    StateNotifierProvider.autoDispose<AddTeamNotifier, AddTeamState>((ref) {
  final teamsService = ref.read(teamsServiceProvider);
  return AddTeamNotifier(teamsService);
});

addTeamEffectProvider(BuildContext context) => Provider.autoDispose((ref) {
      ref.listen<AddTeamState>(addTeamStateProvider, (previous, next) {
        if (next.error.isPresent) {
          AppSnackbar.fromErr(next.error.value).show(context);
        }
        if (next.success.isPresent) {
          ref.read(teamsPagesProvider).toInitPage();
        }
      });
    });
