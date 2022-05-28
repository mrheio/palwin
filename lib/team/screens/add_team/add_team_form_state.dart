import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/ui_utils.dart';
import '../../../game/game.dart';

class AddTeamFormState extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController slotsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Game? game;

  AddTeamFormState({this.game});

  String get name => nameController.text.trim();
  String get slots => slotsController.text.trim();
  String get description => descriptionController.text.trim();

  void setGame(Game? game) {
    this.game = game;
    notifyListeners();
  }

  void disposeControllers() {
    UiUtils.disposeControllers([
      nameController,
      slotsController,
      descriptionController,
    ]);
  }
}

final addTeamFormStateProvider = ChangeNotifierProvider.autoDispose((ref) {
  final addTeamFormState = AddTeamFormState();
  ref.onDispose(() {
    addTeamFormState.disposeControllers();
  });
  return addTeamFormState;
});
