import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:palwin/game/providers.dart';
import 'package:palwin/navigation_listener.dart';
import 'package:palwin/routing/routes.dart';
import 'package:palwin/team/providers.dart';
import 'package:palwin/user/providers.dart';

import 'acccount/providers.dart';
import 'navbar.dart';

class Layout extends ConsumerStatefulWidget {
  final Widget body;
  final int selectedIndex;

  const Layout({
    required this.body,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LayoutState();
  }
}

class _LayoutState extends ConsumerState<Layout> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    ref.watch(navigationListener(context));

    if (GoRouter.of(context).location == entryRoute.path) {
      ref.watch(authEffectProvider(context));
    }

    if (GoRouter.of(context).location == teamsRoute.path) {
      ref.watch(teamsEffectProvider(context));
    }

    if (GoRouter.of(context).location == gamesRoute.path) {
      ref.watch(gamesEffectProvider(context));
    }

    if (GoRouter.of(context).location == accountRoute.path) {
      ref.watch(accountEffectProvider(context));
    }

    return Scaffold(
      body: widget.body,
      bottomNavigationBar: authState.hasUser
          ? Navbar(selectedIndex: widget.selectedIndex)
          : null,
    );
  }
}
