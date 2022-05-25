import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vrouter/vrouter.dart';

class FloatingContent extends ConsumerWidget {
  const FloatingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = VRouter.of(context).url;

    if (url == '/tabs/teams') {
      return FloatingActionButton(
        onPressed: () => VRouter.of(context).to('/tabs/teams/add'),
        child: Icon(
          Icons.add_a_photo,
        ),
      );
    }

    if (url == '/tabs/games') {
      return FloatingActionButton(
        onPressed: () => VRouter.of(context).to('/tabs/games/add'),
        child: Icon(
          Icons.add_comment,
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
