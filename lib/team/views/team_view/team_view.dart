import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:noctur/acccount/providers.dart';
import 'package:noctur/common/styles/app_font_size.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/team/providers.dart';
import 'package:noctur/team/views/team_view/chat_view.dart';
import 'package:noctur/team/views/team_view/team_details_view.dart';
import 'package:optional/optional.dart';
import 'package:styles/styles.dart';

import '../../logic/team.dart';

teamStateEffectProvider(BuildContext context) =>
    Provider.family.autoDispose((ref, String id) {
      ref.listen<AsyncValue<Optional<Team>>>(teamProvider$(id),
          (previous, next) {
        if (next is AsyncData) {
          final maybeTeam = next.value ?? const Optional.empty();
          if (!maybeTeam.isPresent) {
            GoRouter.of(context).pop();
          }
        }
      });
    });

class TeamView extends ConsumerWidget {
  final String id;

  const TeamView(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamProvider$(id));
    final user = ref.watch(authStateProvider.select((value) => value.user))!;
    ref.watch(teamStateEffectProvider(context)(id));

    return state.maybeWhen(
      orElse: () => const Loading(),
      data: (data) => !data.isPresent
          ? const Loading()
          : SafeArea(
              child: SlidablePages(
                controller: PageController(),
                tabs: [
                  Tab(text: data.value.name),
                  const Tab(text: 'Detalii'),
                ],
                children: [
                  user.isInTeam(data.value)
                      ? ChatView(data.value)
                      : Container(
                          alignment: Alignment.center,
                          child: const StyledText(
                            'Nu esti in echipa',
                            size: AppFontSize.h3,
                            semibold: true,
                          ),
                        ),
                  TeamDetailsView(data.value),
                ],
              ),
            ),
    );
  }
}
