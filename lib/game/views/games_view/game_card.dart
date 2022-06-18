import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palwin/acccount/providers.dart';
import 'package:palwin/common/styles/app_font_size.dart';
import 'package:palwin/common/styles/app_spacing.dart';
import 'package:palwin/common/widgets/widgets.dart';
import 'package:palwin/game/logic/game.dart';
import 'package:styles/styles.dart';

import '../../providers.dart';

class GameCard extends ConsumerWidget {
  final Game game;

  const GameCard(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user!;

    return GestureDetector(
      key: Key(game.id),
      onLongPress: !user.isAdmin
          ? null
          : () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(game.name),
                  content: const Text('Stergi jocul?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('NU'),
                    ),
                    TextButton(
                      onPressed: () {
                        ref.read(gamesStateProvider.notifier).deleteGame(game);
                        Navigator.of(context).pop();
                      },
                      child: const Text('DA'),
                    ),
                  ],
                ),
              ),
      child: AppCard(
        onTap: () {},
        child: StyledRow(
          gap: AppSpacing.l,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            game.downloadURL != null
                ? Image.network(
                    game.downloadURL!,
                    width: 56,
                    height: 56,
                  )
                : const Icon(Icons.hide_image_outlined, size: 56),
            Expanded(
              child: StyledColumn(
                gap: AppSpacing.xs,
                children: [
                  StyledText(
                    game.name,
                    size: AppFontSize.h3,
                    semibold: true,
                  ),
                  Players(filled: game.teamSize, total: 0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
