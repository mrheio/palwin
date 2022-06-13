import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noctur/common/app_utils.dart';
import 'package:noctur/common/exceptions/custom_exception.dart';
import 'package:noctur/common/success.dart';
import 'package:noctur/common/utils/disposable_state.dart';
import 'package:noctur/game/logic/games_service.dart';
import 'package:noctur/game/providers.dart';
import 'package:optional/optional.dart';

class AddGameState extends DisposableState {
  final TextEditingController nameController;
  final TextEditingController teamSizeController;
  final File? icon;
  final bool loading;
  final Optional<Success> success;
  final Optional<CustomException> error;

  AddGameState({
    AddGameState? prev,
    Optional<File>? maybeIcon,
    this.loading = false,
    this.success = const Optional.empty(),
    this.error = const Optional.empty(),
  })  : nameController = createTextEditingController(prev?.nameController),
        teamSizeController =
            createTextEditingController(prev?.teamSizeController),
        icon = maybeIcon != null ? maybeIcon.orElseNull : prev?.icon;

  String get name => nameController.text.trim();
  String get teamSize => teamSizeController.text.trim();

  @override
  void onDispose() {
    nameController.dispose();
    teamSizeController.dispose();
  }

  AddGameState copyWith({
    Optional<File>? maybeIcon,
    bool? loading,
    Success? success,
    CustomException? error,
  }) {
    return AddGameState(
      prev: this,
      maybeIcon: maybeIcon,
      loading: loading ?? false,
      success: Optional.ofNullable(success),
      error: Optional.ofNullable(error),
    );
  }
}

class AddGameNotifier extends DisposableStateNotifier<AddGameState> {
  final GamesService _gamesService;

  AddGameNotifier(this._gamesService) : super(AddGameState());

  void setIcon(XFile? icon) {
    if (icon != null) {
      state = state.copyWith(maybeIcon: Optional.of(File(icon.path)));
    }
  }

  void removeIcon() {
    state = state.copyWith(maybeIcon: const Optional.empty());
  }

  Future<void> addGame() async {
    state = state.copyWith(loading: true);
    try {
      await _gamesService.addFromForm(
          name: state.name, teamSize: state.teamSize, file: state.icon);
      state = state.copyWith(success: Success('${state.name} adaugat'));
    } on CustomException catch (error) {
      state = state.copyWith(error: error);
    }
  }
}

final addGameStateProvider =
    StateNotifierProvider.autoDispose<AddGameNotifier, AddGameState>((ref) {
  final gamesService = ref.read(gamesServiceProvider);
  return AddGameNotifier(gamesService);
});

addGameEffectProvider(BuildContext context) => Provider.autoDispose((ref) {
      ref.listen<AddGameState>(addGameStateProvider, (previous, next) {
        if (next.error.isPresent) {
          AppSnackbar.fromErr(next.error.value).show(context);
        }
        if (next.success.isPresent) {
          ref.read(gamesPagesProvider).toInitPage();
        }
      });
    });
