import 'package:go_router/go_router.dart';
import 'package:noctur/home/home_view.dart';
import 'package:noctur/team/views/team_view/team_view.dart';
import 'package:noctur/user/views/account_pages.dart';

import '../acccount/views/entry_pages.dart';
import '../game/views/games_pages.dart';
import '../team/views/teams_pages.dart';

final entryRoute = GoRoute(
  path: 'entry',
  pageBuilder: (context, state) => const NoTransitionPage(child: EntryPages()),
);

final homeRoute = GoRoute(
  path: '/',
  pageBuilder: (context, state) => const NoTransitionPage(child: HomeView()),
  routes: [entryRoute],
);

final teamsViewRoute = GoRoute(
  path: '/teams',
  pageBuilder: (context, state) => const NoTransitionPage(child: TeamsPages()),
  routes: [
    GoRoute(
      path: ':teamId',
      pageBuilder: (context, state) {
        final teamId = state.params['teamId']!;
        return NoTransitionPage(child: TeamView(teamId));
      },
    ),
  ],
);

final gamesViewRoute = GoRoute(
  path: '/games',
  pageBuilder: (context, state) => const NoTransitionPage(child: GamesPages()),
);

final accountRoute = GoRoute(
  path: '/account',
  pageBuilder: (context, state) =>
      const NoTransitionPage(child: AccountPages()),
);
