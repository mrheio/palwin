import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/utils/ui_utils.dart';

class AddGameFormState {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController teamSizeController = TextEditingController();

  String get name => nameController.text.trim();
  String get teamSize => teamSizeController.text.trim();

  void dispose() {
    UiUtils.disposeControllers([
      nameController,
      teamSizeController,
    ]);
  }
}

final addGameFormStateProvider = Provider.autoDispose((ref) {
  final addGameFormState = AddGameFormState();
  ref.onDispose(() {
    addGameFormState.dispose();
  });
  return addGameFormState;
});
