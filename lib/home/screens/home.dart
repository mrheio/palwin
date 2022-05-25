import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/auth_providers.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/home/screens/welcome_screen.dart';

import '../../game/screens/add_game/add_game.dart';
import '../../game/screens/games_view/games_view.dart';
import '../../team/screens/teams_view/teams_view.dart';
import '../../user/screens/profile_view.dart';

class Home extends ConsumerWidget {
  final _beamerKey = GlobalKey<BeamerState>();
  final _routerDelegate = BeamerDelegate(
    initialPath: '/teams',
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/teams': (context, state, data) => TeamsView(),
        '/games': (context, state, data) => GamesView(),
        '/games/add': (context, state, data) => AddGame(),
        '/user': (context, state, data) => ProfileView(),
      },
    ),
  );

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);

    if (authState.loading) {
      return const Loading(condition: true);
    }

    if (authState.user == null) {
      return const WelcomeScreen();
    }

    return SizedBox.shrink();
  }
}
