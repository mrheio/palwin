import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/styles/app_font_size.dart';
import 'package:noctur/common/styles/app_spacing.dart';
import 'package:noctur/common/widgets/loading.dart';
import 'package:noctur/team/logic/logic.dart';
import 'package:noctur/team/logic/message.dart';
import 'package:noctur/team/providers.dart';
import 'package:styles/styles.dart';

class ChatView extends ConsumerWidget {
  final Team team;

  const ChatView(this.team, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(teamMessagesProvider$(team.id));

    return state.maybeWhen(
      orElse: () => const Loading(),
      data: (data) => StyledColumn(
        children: [
          Expanded(
            child: StyledList<Message>(
              gap: AppSpacing.m,
              padding: const EdgeInsets.all(AppSpacing.m),
              reverse: true,
              items: data,
              displayBuilder: (message) => StyledColumn(
                gap: AppSpacing.xs,
                children: [
                  StyledText(
                    message.user.username,
                    size: AppFontSize.h5,
                    semibold: true,
                  ),
                  StyledText(message.text)
                ],
              ),
            ),
          ),
          _MessageInput(team),
        ],
      ),
    );
  }
}

class _MessageInput extends ConsumerStatefulWidget {
  final Team team;

  const _MessageInput(this.team);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MessageInputState();
  }
}

class _MessageInputState extends ConsumerState<_MessageInput> {
  final messageController = TextEditingController();
  var hasText = false;

  void handleMessageChange() {
    if (messageController.text.isNotEmpty && !hasText) {
      setState(() {
        hasText = true;
      });
    }
    if (messageController.text.isEmpty && hasText) {
      setState(() {
        hasText = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    messageController.addListener(handleMessageChange);
  }

  @override
  void dispose() {
    messageController.removeListener(handleMessageChange);
    messageController.dispose();
    super.dispose();
  }

  Future<void> sendMessage() async {
    await ref
        .read(teamsServiceProvider)
        .sendMessage(widget.team, messageController.text.trim());
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: AppSpacing.m, right: AppSpacing.m, bottom: AppSpacing.s),
      child: StyledRow(
        gap: AppSpacing.m,
        children: [
          Expanded(
            child: StyledTextField(
              controller: messageController,
            ),
          ),
          StyledButtonCircle(
            onPressed: hasText ? sendMessage : null,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
