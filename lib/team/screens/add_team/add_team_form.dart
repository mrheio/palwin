import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/styles.dart';
import '../../../common/utils/validator.dart';
import '../../../common/widgets/app_button.dart';
import '../../../common/widgets/app_column.dart';
import '../../../common/widgets/app_select_field.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../game/game.dart';
import '../../../game/game_providers.dart';
import 'add_team_form_state.dart';
import 'add_team_state.dart';

class AddTeamForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey;

  AddTeamForm({Key? key})
      : _formKey = GlobalKey<FormState>(),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final games = ref.watch(gamesProvider$).value ?? [];
    final state = ref.watch(addTeamFormStateProvider);
    final notifier = ref.read(addTeamStateProvider.notifier);

    return Form(
      key: _formKey,
      child: AppColumn(
        spacing: AppSpacing.m,
        children: [
          AppTextField(
            controller: state.nameController,
            hint: 'Nume echipa',
            validators: const [Validator.required],
          ),
          AppSelectField<Game>(
            value: state.game,
            items: games,
            validators: const [Validator.required],
            onChanged: state.setGame,
            displayMapper: (e) => Text(e.name),
            hint: 'Joc',
          ),
          AppTextField(
            controller: state.slotsController,
            hint: 'Numar jucatori in echipa',
            validators: const [Validator.required, Validator.numeric],
          ),
          AppTextField(
            controller: state.descriptionController,
            hint: 'Descriere',
          ),
          AppButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                notifier.addTeam();
              }
            },
            child: const Text('Adauga echipa'),
            fillWidth: true,
          ),
        ],
      ),
    );
  }
}
