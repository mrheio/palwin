import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/user/views/manage_account_view.dart/manage_account_view.dart';
import 'package:styles/styles.dart';

class AccountPages extends ConsumerWidget {
  const AccountPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SlidablePages(
        controller: PageController(),
        tabs: const [
          Tab(text: 'Detalii cont'),
        ],
        children: [
          ManageAccountView(),
        ],
      ),
    );
  }
}
