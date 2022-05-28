import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/app_widgets.dart';
import 'teams_filter_dialog.dart';
import 'teams_list.dart';

class TeamsView extends ConsumerWidget {
  const TeamsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppColumn(
      children: [
        SectionTitle(
          child: AppRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Header('Echipe'),
              IconButton(
                onPressed: () {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => const TeamsFilterDialog(),
                  );
                },
                icon: const Icon(
                  Icons.tune,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
        const Expanded(
          child: TeamsList(),
        ),
      ],
    );
  }
}
