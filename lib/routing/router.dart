import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noctur/auth/auth_providers.dart';
import 'package:noctur/auth/auth_state.dart';
import 'package:noctur/auth/screens/login/login.dart';
import 'package:noctur/auth/screens/register/register.dart';
import 'package:noctur/game/screens/games_home.dart';
import 'package:noctur/home/screens/home.dart';
import 'package:noctur/layout.dart';
import 'package:noctur/team/screens/teams_home/teams_home.dart';
import 'package:noctur/user/screens/profile.dart';

final tabs = {0: '/teams', 1: '/games', 2: '/user'};

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(authStateNotifierProvider, (previous, next) {
      notifyListeners();
    });
  }
}

final routerProvider = Provider((ref) {
  String? _redirect(GoRouterState state) {
    final onHomeScreen = state.location == '/';
    final onNotAuthScreen =
        state.location == '/login' || state.location == '/register';

    final user = ref.read(authStateNotifierProvider).user;

    if (user == null) {
      if (!onNotAuthScreen && !onHomeScreen) {
        return '/';
      }
      return null;
    }

    if (onNotAuthScreen) {
      return '/';
    }

    return null;
  }

  final routes = [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      name: 'teams',
      path: '/teams',
      builder: (context, state) {
        return TeamsHome();
      },
    ),
    GoRoute(
      name: 'games',
      path: '/games',
      builder: (context, state) {
        return GamesHome();
      },
    ),
    GoRoute(
      name: 'user',
      path: '/user',
      builder: (context, state) {
        return Profile();
      },
    ),
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => Login(),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => Register(),
    ),
  ];

  Widget _navigatorBuilder(
      BuildContext context, GoRouterState state, Widget child) {
    final user = ref.read(authStateNotifierProvider).user;

    return Navigator(
      onPopPage: (route, result) => false,
      pages: [
        if (user == null) MaterialPage(child: child),
        if (user != null)
          MaterialPage(
            child: Layout(
              body: child,
              currentIndex: tabs.keys.firstWhere(
                  (k) => tabs[k] == state.location,
                  orElse: () => 0),
            ),
          ),
      ],
    );
  }

  return GoRouter(
      debugLogDiagnostics: true,
      refreshListenable: RouterNotifier(ref),
      redirect: _redirect,
      routes: routes,
      navigatorBuilder: _navigatorBuilder);
});
