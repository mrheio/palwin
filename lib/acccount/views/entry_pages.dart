import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palwin/acccount/providers.dart';
import 'package:palwin/acccount/views/login_view.dart';
import 'package:palwin/acccount/views/register_view.dart';
import 'package:styles/styles.dart';

class EntryPages extends ConsumerWidget {
  const EntryPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller =
        ref.watch(entryPagesProvider.select((value) => value.controller));

    return SafeArea(
      child: SlidablePages(
        controller: controller,
        tabs: const [
          Tab(text: 'Autentificare'),
          Tab(text: 'Inregistrare'),
        ],
        children: const [
          LoginView(),
          RegisterView(),
        ],
      ),
    );
  }
}
