import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/app_widgets.dart';
import 'games_list.dart';

class GamesView extends ConsumerWidget {
  const GamesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const AppColumn(
      children: [
        SectionTitle(child: Header('Jocuri')),
        Expanded(child: GamesList()),
      ],
    );
  }
}
