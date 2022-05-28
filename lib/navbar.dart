import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:vrouter/vrouter.dart';

import 'common/styles.dart';
import 'nav_state.dart';

class Navbar extends ConsumerWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(navStateNotifierProvider);
    final notifier = ref.read(navStateNotifierProvider.notifier);

    ref.listen<NavState>(navStateNotifierProvider, (previous, next) {
      VRouter.of(context).to(next.tab);
    });

    return SalomonBottomBar(
      currentIndex: state.index,
      onTap: notifier.setIndex,
      selectedItemColor: AppColor.secondary[50],
      items: [
        SalomonBottomBarItem(
          icon: Icon(Icons.group),
          title: Text('Echipe'),
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.gamepad),
          title: Text("Jocuri"),
        ),
        SalomonBottomBarItem(
          icon: Icon(Icons.search),
          title: Text("Profil"),
        ),
      ],
    );
  }
}
