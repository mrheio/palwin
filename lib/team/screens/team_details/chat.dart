import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/message/message_providers.dart';
import 'package:noctur/team/screens/team_details/chat_state.dart';
import 'package:noctur/team/team.dart';
import 'package:noctur/team/team_providers.dart';

import '../../../common/app_widgets.dart';
import '../../../common/styles.dart';
import '../../../message/message.dart';

final _scrollControllerProvider = Provider.autoDispose((ref) {
  final controller = ScrollController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

class Chat extends ConsumerWidget {
  final Team team;

  const Chat(this.team, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(teamMessagesProvider$(team.id)).maybeWhen(
          orElse: () => const Loading(),
          data: (messages) => AppColumn(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _MessagesList(messages),
                ),
              ),
              _SendMessageTextField(team),
            ],
          ),
        );
  }
}

class _MessagesList extends ConsumerWidget {
  final List<Message> messages;

  const _MessagesList(this.messages);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(_scrollControllerProvider);

    return ListView.separated(
      controller: scrollController,
      reverse: true,
      separatorBuilder: (context, index) => const SizedBox(height: 4),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final m = messages[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: _MessageSpan(m),
        );
      },
    );
  }
}

class _MessageSpan extends StatelessWidget {
  final Message message;

  const _MessageSpan(this.message);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Header(
              message.user.value.username,
              margin: const EdgeInsets.only(right: 8),
              size: AppFontSize.h5,
              weight: AppFontWeight.semibold,
            ),
          ),
          TextSpan(
            text: message.message,
            style: const TextStyle(
              color: AppColor.textDim,
            ),
          ),
        ],
      ),
    );
  }
}

class _SendMessageTextField extends ConsumerWidget {
  final Team team;

  const _SendMessageTextField(this.team);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chatStateProvider);
    final scrollController = ref.watch(_scrollControllerProvider);

    Future<void> sendMessage() async {
      await ref
          .read(messageServiceProvider(team.id))
          .sendMessage(state.message);
      state.clearController();
      scrollController.jumpTo(0);
    }

    return AppRow(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      spacing: AppSpacing.m,
      children: [
        Expanded(
          child: AppTextField(
            controller: state.messageController,
            maxLines: null,
            onChanged: state.handleMessageInputChange,
          ),
        ),
        AppCircleButton(
          child: const Icon(Icons.send),
          onPressed: state.hasMessageToSend ? sendMessage : null,
        )
      ],
    );
  }
}
