import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/widgets/app_button.dart';
import 'package:noctur/common/widgets/app_column.dart';
import 'package:noctur/game/screens/add_game/add_game_state.dart';

import '../../../common/utils/validator.dart';
import '../../../common/widgets/app_text_field.dart';

class AddGameForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey;

  AddGameForm({Key? key})
      : _formKey = GlobalKey<FormState>(),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addGameState = ref.watch(addGameStateNotifierProvider);
    final addGameNotifier = ref.read(addGameStateNotifierProvider.notifier);

    return Form(
      key: _formKey,
      child: AppColumn(
        spacing: 16,
        children: [
          AppTextField(
            controller: addGameState.nameField,
            hint: 'Nume joc',
            validators: const [Validator.required],
          ),
          AppTextField(
            controller: addGameState.capacityField,
            hint: 'Numar maxim jucatori in echipa',
            validators: const [Validator.required, Validator.numeric],
          ),
          AppButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                addGameNotifier.addGame();
              }
            },
            child: const Text('Adauga joc'),
            fillWidth: true,
          ),
        ],
      ),
    );
  }
}
