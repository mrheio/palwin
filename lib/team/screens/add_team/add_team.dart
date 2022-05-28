import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/styles.dart';
import '../../../common/utils/ui_utils.dart';
import '../../../common/widgets/app_column.dart';
import '../../../common/widgets/header.dart';
import '../../../common/widgets/loading.dart';
import '../../../game/game_providers.dart';
import 'add_team_form.dart';
import 'add_team_state.dart';

class AddTeam extends ConsumerWidget {
  const AddTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addTeamStateProvider);

    ref.listen<AddTeamState>(addTeamStateProvider, (prev, next) {
      if (next is AddTeamSuccess) {
        UiUtils.maybeShowSnackbar(context, next.success.message);
        UiUtils.maybePop(context, true);
      }
      if (next is AddTeamError) {
        UiUtils.maybeShowSnackbar(context, next.error.message);
      }
    });

    return Loading(
      condition: state is AddTeamLoading,
      child: ref.watch(gamesProvider$).maybeWhen(
            orElse: () => const Loading(),
            data: (_) => Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(AppSpacing.m),
                  child: AppColumn(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: AppSpacing.l,
                    children: [
                      const Header('Adauga o echipa'),
                      AddTeamForm(),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
