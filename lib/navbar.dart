import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:palwin/routing/routes.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'common/styles/app_color.dart';

class Navbar extends StatefulWidget {
  final int selectedIndex;

  const Navbar({
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NavbarState();
  }
}

class _NavbarState extends State<Navbar> {
  void _handleTap(int index) {
    if (index == 0) {
      GoRouter.of(context).go(homeRoute.path);
    }
    if (index == 1) {
      GoRouter.of(context).go(teamsRoute.path);
    }
    if (index == 2) {
      GoRouter.of(context).go(gamesRoute.path);
    }
    if (index == 3) {
      GoRouter.of(context).go(accountRoute.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: widget.selectedIndex,
      onTap: _handleTap,
      selectedItemColor: AppColor.secondary[50],
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.home),
          title: const Text('Acasa'),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.group),
          title: const Text('Echipe'),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.gamepad),
          title: const Text("Jocuri"),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.person),
          title: const Text("Profil"),
        ),
      ],
    );
  }
}
