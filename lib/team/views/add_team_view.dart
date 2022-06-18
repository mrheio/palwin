import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:input_validator/input_validator.dart';
import 'package:palwin/acccount/providers.dart';
import 'package:palwin/common/styles.dart';
import 'package:palwin/common/utils.dart';
import 'package:palwin/common/widgets/loading.dart';
import 'package:styles/styles.dart';

import '../../game/logic/game.dart';
import '../../game/providers.dart';
import '../providers.dart';

class AddTeamView extends ConsumerStatefulWidget {
  const AddTeamView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddTeamState();
  }
}

class _AddTeamState extends ConsumerState<AddTeamView> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final slotsController = TextEditingController();
  final descriptionController = TextEditingController();
  Game? game;

  @override
  void dispose() {
    nameController.dispose();
    slotsController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void setGame(Game? val) {
    setState(() {
      game = val;
    });
  }

  Future<void> addTeam() async {
    if (formKey.currentState!.validate()) {
      final user = ref.read(authStateProvider).user!;
      await ref.read(teamsStateProvider.notifier).addTeam(
            name: getText(nameController),
            slots: getText(slotsController),
            description: getText(descriptionController),
            game: game!,
            user: user.toSimpleUser(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gamesState = ref.watch(gamesStateProvider);
    final status = ref.watch(teamsStateProvider).status;

    if (status is LoadingStatus || gamesState.status is LoadingStatus) {
      return const Loading();
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: StyledColumn(
            gap: AppSpacing.m,
            children: [
              StyledTextField(
                label: 'Nume',
                controller: nameController,
                validator: const InputValidator().notEmpty().create(),
              ),
              StyledSelectField<Game>(
                label: 'Joc',
                value: game,
                items: gamesState.games,
                onChanged: setGame,
                displayMapper: (game) => StyledText(game.name),
                validator: const InputValidator().notEmpty().create(),
              ),
              StyledTextField(
                label: 'Cati jucatori in echipa?',
                controller: slotsController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: const InputValidator().notEmpty().numeric().create(),
              ),
              StyledTextField(
                label: 'Descriere',
                controller: descriptionController,
              ),
              StyledButtonFluid(
                onPressed: addTeam,
                child: const StyledText('Adauga echipa'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
