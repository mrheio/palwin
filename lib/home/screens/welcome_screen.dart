import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrouter/vrouter.dart';

import '../../common/widgets/app_button.dart';
import '../../common/widgets/app_column.dart';
import '../../common/widgets/header.dart';
import '../../common/widgets/logo.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: AppColumn(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Logo(),
            const Header('Bine ai venit'),
            AppButton(
              onPressed: () => VRouter.of(context).to('/register'),
              child: const Text('Creeaza cont'),
              fillWidth: true,
            ),
            AppButton(
              onPressed: () => VRouter.of(context).to('/login'),
              child: const Text('Intra in cont'),
              fillWidth: true,
            )
          ],
        ),
      ),
    );
  }
}
