import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../layout.dart';
import 'routes.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    debugLogDiagnostics: true,
    navigatorBuilder: (context, state, child) {
      int pickIndex() {
        if (state.subloc == '/') {
          return 0;
        }
        if (state.subloc.contains('teams')) {
          return 1;
        }
        if (state.subloc.contains('games')) {
          return 2;
        }
        if (state.subloc.contains('account')) {
          return 3;
        }

        return 0;
      }

      return Navigator(
        onPopPage: (route, dynamic result) {
          route.didPop(result);
          return false;
        },
        pages: [
          MaterialPage(
            child: Layout(
              body: child,
              selectedIndex: pickIndex(),
            ),
          )
        ],
      );
    },
    routes: [
      homeRoute,
      teamsRoute,
      gamesRoute,
      accountRoute,
    ],
  );
});
