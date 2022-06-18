import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/common/styles/app_font_size.dart';
import 'package:noctur/user/logic/logic.dart';
import 'package:styles/styles.dart';

import '../../common/styles.dart';
import '../widgets/user_card.dart';

class FriendsView extends ConsumerWidget {
  const FriendsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).user!;

    return user.friends.isEmpty
        ? Container(
            alignment: Alignment.center,
            child: const StyledText(
              'Nu ai prieteni adaugati',
              size: AppFontSize.h3,
              semibold: true,
            ),
          )
        : StyledList<Friend>(
            items: user.friends,
            gap: AppSpacing.s,
            displayBuilder: (user) => UserCard(null, user),
          );
  }
}
