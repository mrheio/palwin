import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/routing/router.dart';

import 'acccount/providers.dart';

navigationListener(BuildContext context) => Provider.autoDispose((ref) async {
      final user = await ref.watch(userProvider$.future);

      if (user.isPresent) {
        final location = ref.read(routerProvider).location;
        if (location.contains('entry')) {
          ref.read(routerProvider).go('/');
        }
      }

      if (!user.isPresent) {
        final location = ref.read(routerProvider).location;
        if (location.contains('teams') ||
            location.contains('games') ||
            location.contains('account')) {
          ref.read(routerProvider).go('/');
        }
      }
    });
