import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/team/providers.dart';
import 'package:noctur/team/views/add_team_view/add_team_view.dart';
import 'package:noctur/team/views/teams_view/teams_view.dart';
import 'package:styles/styles.dart';

class TeamsPages extends ConsumerWidget {
  const TeamsPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller =
        ref.watch(teamsPagesProvider.select((value) => value.controller));

    return SafeArea(
      child: SlidablePages(
        controller: controller,
        tabs: const [
          Tab(text: 'Echipe'),
          Tab(text: 'Adauga echipa'),
        ],
        children: [
          const TeamsView(),
          AddTeamView(),
        ],
      ),
    );
  }
}
