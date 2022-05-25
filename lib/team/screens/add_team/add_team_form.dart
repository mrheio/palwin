import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/utils/validator.dart';
import 'package:noctur/common/widgets/app_button.dart';
import 'package:noctur/common/widgets/app_column.dart';
import 'package:noctur/common/widgets/app_select_field.dart';
import 'package:noctur/common/widgets/app_text_field.dart';
import 'package:noctur/team/screens/add_team/add_team_state.dart';

import '../../../game/game.dart';

class AddTeamForm extends ConsumerWidget {
  final GlobalKey<FormState> _formKey;

  AddTeamForm({Key? key})
      : _formKey = GlobalKey<FormState>(),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addTeamState = ref.watch(addTeamStateNotifierProvider);
    final addTeamNotifier = ref.read(addTeamStateNotifierProvider.notifier);

    return Form(
      key: _formKey,
      child: AppColumn(
        spacing: 16,
        children: [
          AppTextField(
            controller: addTeamState.nameField,
            hint: 'Nume echipa',
            validators: [Validator.required],
          ),
          AppSelectField<Game>(
            value: addTeamState.game,
            items: addTeamState.games,
            validators: [Validator.required],
            onChanged: addTeamNotifier.setGame,
            displayMapper: (e) => Text(e.name),
            hint: 'Joc',
          ),
          AppTextField(
            controller: addTeamState.capacityField,
            hint: 'Numar jucatori in echipa',
            validators: [Validator.required, Validator.numeric],
          ),
          AppTextField(
            controller: addTeamState.descriptionField,
            hint: 'Descriere',
          ),
          AppButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                addTeamNotifier.addTeam();
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
