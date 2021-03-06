import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palwin/team/providers.dart';
import 'package:palwin/team/views/add_team_view.dart';
import 'package:palwin/team/views/teams_view/teams_view.dart';
import 'package:styles/styles.dart';

class TeamsPages extends ConsumerWidget {
  const TeamsPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(teamsPagesProvider).controller;

    return SafeArea(
      child: SlidablePages(
        controller: controller,
        tabs: const [
          Tab(text: 'Echipe'),
          Tab(text: 'Adauga echipa'),
        ],
        children: const [
          TeamsView(),
          AddTeamView(),
        ],
      ),
    );
  }
}
