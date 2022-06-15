import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles/app_font_size.dart';
import 'package:noctur/common/styles/app_spacing.dart';
import 'package:noctur/common/widgets/widgets.dart';
import 'package:noctur/game/logic/game.dart';
import 'package:noctur/game/providers.dart';
import 'package:styles/styles.dart';

class GameCard extends ConsumerWidget {
  final Game game;

  const GameCard(this.game, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> deleteGame(DismissDirection direction) async {
      await ref.read(gamesServiceProvider).deleteGame(game);
    }

    return Dismissible(
      key: Key(game.id),
      onDismissed: deleteGame,
      child: AppCard(
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
