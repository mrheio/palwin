import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:input_validator/input_validator.dart';
import 'package:noctur/common/styles/app_spacing.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/game/providers.dart';
import 'package:noctur/team/views/add_team_view/add_team_state.dart';
import 'package:styles/styles.dart';

import '../../../game/logic/game.dart';

class AddTeamView extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddTeamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addTeamStateProvider);
    final games = ref.watch(gamesProvider$).value ?? [];
    ref.watch(addTeamEffectProvider(context));

    if (state.loading) {
      return const Loading();
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: StyledColumn(
            gap: AppSpacing.m,
            children: [
              StyledTextField(
                label: 'Nume',
                controller: state.nameController,
                validator: const InputValidator().notEmpty().create(),
              ),
              StyledSelectField<Game>(
                label: 'Joc',
                value: state.game,
                items: games,
                onChanged: ref.read(addTeamStateProvider.notifier).setGame,
                displayMapper: (game) => StyledText(game.name),
                validator: const InputValidator().notEmpty().create(),
              ),
              StyledTextField(
                label: 'Cati jucatori in echipa?',
                controller: state.slotsController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: const InputValidator().notEmpty().numeric().create(),
              ),
              StyledTextField(
                label: 'Descriere',
                controller: state.descriptionController,
              ),
              StyledButtonFluid(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref.read(addTeamStateProvider.notifier).addTeam();
                  }
                },
                child: const StyledText('Adauga echipa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
