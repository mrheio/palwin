import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/utils.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/home/main_view.dart';
import 'package:noctur/home/welcome_view.dart';

import '../acccount/providers.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    if (authState.status is LoadingStatus) {
      return const Loading();
    }

    if (authState.hasUser) {
      return const MainView();
    }

    return const WelcomeView();
  }
}
