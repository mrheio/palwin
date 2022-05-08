import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/auth_providers.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/home/screens/welcome_screen.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);
    final authNotifier = ref.read(authStateNotifierProvider.notifier);

    if (authState.loading) {
      return const Loading(condition: true);
    }

    if (authState.user == null) {
      return const WelcomeScreen();
    }

    return Scaffold(
      body: Container(
        child: ElevatedButton(
          onPressed: authNotifier.logOut,
          child: Text('iesi din cont'),
        ),
      ),
    );
  }
}
