import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles.dart';

import '../../../common/app_widgets.dart';
import '../../../common/utils/validator.dart';
import 'add_game_form_state.dart';
import 'add_game_state.dart';

class AddGameForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey;

  AddGameForm({Key? key})
      : _formKey = GlobalKey<FormState>(),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addGameFormStateProvider);
    final notifier = ref.read(addGameStateProvider.notifier);

    Future<void> handleAddGame() async {
      if (_formKey.currentState!.validate()) {
        await notifier.addGame();
      }
    }

    return Form(
      key: _formKey,
      child: AppColumn(
        spacing: AppSpacing.m,
        children: [
          AppTextField(
            controller: state.nameController,
            hint: 'Nume joc',
            validators: const [Validator.required],
          ),
          AppTextField(
            controller: state.teamSizeController,
            hint: 'Numar maxim jucatori in echipa',
            validators: const [Validator.required, Validator.numeric],
          ),
          AppButton(
            onPressed: handleAddGame,
            child: const Text('Adauga joc'),
            fillWidth: true,
          ),
        ],
      ),
    );
  }
}
