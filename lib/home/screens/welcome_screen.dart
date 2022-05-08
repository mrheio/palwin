import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => GoRouter.of(context).push('/register'),
              child: const Text('Creeaza cont'),
            ),
            ElevatedButton(
              onPressed: () => GoRouter.of(context).push('/login'),
              child: const Text('Intra in cont'),
            ),
          ],
        ),
      ),
    );
  }
}
