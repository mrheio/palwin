import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/auth_providers.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.read(authStateProvider.notifier);

    return Container(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: authNotifier.logOut,
            child: Text('iesi din cont'),
          ),
        ],
      ),
    );
  }
}
