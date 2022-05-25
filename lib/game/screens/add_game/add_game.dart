import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/utils/ui_utils.dart';
import 'package:noctur/common/widgets/app_column.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/game/screens/add_game/add_game_form.dart';
import 'package:noctur/game/screens/add_game/add_game_state.dart';

import '../../../common/widgets/header.dart';

class AddGame extends ConsumerWidget {
  const AddGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(addGameStateNotifierProvider).loading;

    ref.listen<AddGameState>(addGameStateNotifierProvider, (prev, next) {
      final success = next.success;
      UiUtils.maybeShowSnackbar(context, success?.message);
      UiUtils.maybePop(context, success != null);
    });

    return Container(
      padding: const EdgeInsets.all(16),
      child: Loading(
        condition: loading,
        child: AppColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 24,
          children: [
            const Header('Adauga joc'),
            AddGameForm(),
          ],
        ),
      ),
    );
  }
}
