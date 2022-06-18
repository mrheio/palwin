import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/user/providers.dart';
import 'package:styles/styles.dart';

import 'manage_account_view.dart';

class AccountPages extends ConsumerWidget {
  const AccountPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(accountPagesStateProvider).controller;

    return SafeArea(
      child: SlidablePages(
        controller: controller,
        tabs: const [
          Tab(text: 'Detalii cont'),
        ],
        children: const [
          ManageAccountView(),
        ],
      ),
    );
  }
}
