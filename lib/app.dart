import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/screens/login/login.dart';
import 'package:noctur/auth/screens/register/register.dart';
import 'package:noctur/common/styles.dart';
import 'package:noctur/game/screens/add_game/add_game.dart';
import 'package:noctur/home/screens/home.dart';
import 'package:noctur/team/screens/add_team/add_team.dart';
import 'package:noctur/team/screens/team_details/team_details.dart';
import 'package:noctur/team/screens/teams_view/teams_view.dart';
import 'package:noctur/user/screens/profile_view.dart';
import 'package:vrouter/vrouter.dart';

import 'auth_guard.dart';
import 'game/screens/games_view/games_view.dart';
import 'layout.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VRouter(
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColor.bg,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.primary[20],
        ),
      ),
      builder: (context, child) => AuthGuard(child: child),
      routes: [
        VGuard(
          stackedRoutes: [
            VWidget(
              path: '/',
              widget: Home(),
              stackedRoutes: [
                VWidget(path: 'login', widget: const Login()),
                VWidget(path: 'register', widget: const Register()),
              ],
            ),
          ],
        ),
        VNester(
          path: '/tabs',
          widgetBuilder: (child) => Layout(body: child),
          nestedRoutes: [
            VWidget(
              path: 'teams',
              widget: const TeamsView(),
              stackedRoutes: [
                VWidget(path: 'add', widget: AddTeam()),
                VWidget(
                  path: ':teamId',
                  widget: Builder(builder: (context) {
                    final teamId =
                        VRouter.of(context).pathParameters['teamId']!;
                    return TeamDetails(teamId: teamId);
                  }),
                ),
              ],
            ),
            VWidget(
              path: 'games',
              widget: const GamesView(),
              stackedRoutes: [
                VWidget(path: 'add', widget: AddGame()),
              ],
            ),
            VWidget(path: 'user', widget: const ProfileView()),
          ],
        ),
      ],
    );
  }
}
