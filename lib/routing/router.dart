import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noctur/auth/auth_providers.dart';
import 'package:noctur/auth/auth_state.dart';
import 'package:noctur/auth/screens/login/login.dart';
import 'package:noctur/auth/screens/register/register.dart';
import 'package:noctur/home/screens/home.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(authStateNotifierProvider, (previous, next) {
      notifyListeners();
    });
  }
}

final routerProvider = Provider((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: RouterNotifier(ref),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => Login(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => Register(),
      ),
    ],
    redirect: (state) {
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
    },
  );
});
