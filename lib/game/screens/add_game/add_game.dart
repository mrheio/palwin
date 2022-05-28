import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/app_widgets.dart';
import '../../../common/styles.dart';
import '../../../common/utils/ui_utils.dart';
import 'add_game_form.dart';
import 'add_game_state.dart';

class AddGame extends ConsumerWidget {
  const AddGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addGameStateProvider);

    ref.listen<AddGameState>(addGameStateProvider, (prev, next) {
      if (next is AddGameSuccess) {
        UiUtils.showSnackbar(context, next.success.message);
        UiUtils.maybePop(context, true);
      }
      if (next is AddGameError) {
        UiUtils.showSnackbar(context, next.error.message);
      }
    });

    return Loading(
      condition: state is AddGameLoading,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.m),
            child: AppColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSpacing.l,
              children: [
                const Header('Adauga o echipa'),
                AddGameForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
