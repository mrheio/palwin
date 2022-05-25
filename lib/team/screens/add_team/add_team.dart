import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/widgets/app_column.dart';
import 'package:noctur/common/widgets/header.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/team/screens/add_team/add_team_form.dart';
import 'package:noctur/team/screens/add_team/add_team_state.dart';

import '../../../common/utils/ui_utils.dart';

class AddTeam extends ConsumerWidget {
  const AddTeam({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loading = ref.watch(addTeamStateNotifierProvider).loading;

    ref.listen<AddTeamState>(addTeamStateNotifierProvider, (prev, next) {
      final error = next.error;
      final success = next.success;
      UiUtils.maybeShowSnackbar(context, error?.message);
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
            const Header('Adauga o echipa'),
            AddTeamForm(),
          ],
        ),
      ),
    );
  }
}
