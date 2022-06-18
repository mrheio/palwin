import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palwin/routing/router.dart';

import 'acccount/providers.dart';

final navigationListener =
    Provider.family.autoDispose((ref, BuildContext context) {
  final authState = ref.watch(authStateProvider);

  if (authState.hasUser) {
    final location = ref.read(routerProvider).location;
    if (location.contains('entry')) {
      ref.read(routerProvider).go('/');
    }
  }

  if (!authState.hasUser) {
    final location = ref.read(routerProvider).location;
    if (location.contains('teams') ||
        location.contains('games') ||
        location.contains('account')) {
      ref.read(routerProvider).go('/');
    }
  }
});
