import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noctur/auth/auth_providers.dart';

class TeamsHome extends ConsumerWidget {
  const TeamsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authStateNotifierProvider.notifier);

    return Container(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: authNotifier.logOut,
            child: Text('iesi din cont'),
          ),
          ElevatedButton(
            onPressed: () => GoRouter.of(context).push('/main/games'),
            child: Text('Du-te'),
          ),
        ],
      ),
    );
  }
}
