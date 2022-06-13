import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/common/styles/app_font_size.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/game/providers.dart';
import 'package:noctur/game/views/add_game_view/add_game_view.dart';
import 'package:noctur/game/views/games_view/games_view.dart';
import 'package:styles/styles.dart';

class GamesPages extends ConsumerWidget {
  const GamesPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller =
        ref.watch(gamesPagesProvider.select((value) => value.controller));

    return ref.watch(userProvider$).maybeWhen(
          orElse: () => const Loading(),
          data: (data) => SafeArea(
            child: SlidablePages(
              controller: controller,
              tabs: const [
                Tab(text: 'Jocuri'),
                Tab(text: 'Adauga joc'),
              ],
              children: [
                const GamesView(),
                data.value.isAdmin
                    ? AddGameView()
                    : Container(
                        color: Colors.black.withAlpha(200),
                        alignment: Alignment.center,
                        child: const StyledText(
                          'Doar adminii pot adauga jocuri',
                          size: AppFontSize.h4,
                          semibold: true,
                        ),
                      ),
              ],
            ),
          ),
        );
  }
}
