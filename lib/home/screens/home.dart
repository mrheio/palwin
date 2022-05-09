import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/auth_providers.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/home/screens/welcome_screen.dart';
import 'package:noctur/team/screens/teams_home/teams_home.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);

    if (authState.loading) {
      return const Loading(condition: true);
    }

    if (authState.user == null) {
      return const WelcomeScreen();
    }

    return TeamsHome();
  }
}
