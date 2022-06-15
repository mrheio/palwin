import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/navigation_listener.dart';
import 'package:optional/optional.dart';

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
    final user = ref.watch(userProvider$).value ?? const Optional.empty();
    ref.watch(navigationListener(context));

    return Scaffold(
      body: widget.body,
      bottomNavigationBar:
          user.isPresent ? Navbar(selectedIndex: widget.selectedIndex) : null,
    );
  }
}
