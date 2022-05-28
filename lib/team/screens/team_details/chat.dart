import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/styles.dart';
import '../../../common/widgets/app_circle_button.dart';
import '../../../common/widgets/app_column.dart';
import '../../../common/widgets/app_row.dart';
import '../../../common/widgets/app_text_field.dart';
import '../../../common/widgets/header.dart';
import '../../../common/widgets/loading.dart';
import '../../../message/message.dart';
import 'chat_state.dart';

class Chat extends ConsumerWidget {
  final ScrollController _controller;
  final String teamId;

  Chat({required this.teamId, Key? key})
      : _controller = ScrollController(),
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatStateProvider(teamId));
    final messages = chatState.messages;
    final loading = chatState.loading;

    ref.listen<ChatState>(chatStateProvider(teamId), (prev, next) {
      final success = next.success;
      if (success != null) {
        _controller.jumpTo(0);
      }
    });

    return Loading(
      condition: loading,
      child: AppColumn(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ListView.separated(
                controller: _controller,
                reverse: true,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 4,
                ),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final m = messages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _MessageSpan(m),
                  );
                },
              ),
            ),
          ),
          _SendMessageTextField(teamId),
        ],
      ),
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
  final String teamId;

  const _SendMessageTextField(this.teamId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(chatStateProvider(teamId)).messageField;
    final hasText = ref.watch(chatStateProvider(teamId)).hasText;
    final notifier = ref.read(chatStateProvider(teamId).notifier);

    return AppRow(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      spacing: 8,
      children: [
        Expanded(
          child: AppTextField(
            controller: controller,
            maxLines: null,
            onChanged: (val) => notifier.handleTextChange(),
          ),
        ),
        AppCircleButton(
          child: const Icon(Icons.send),
          onPressed: hasText ? notifier.addMessage : null,
        )
      ],
    );
  }
}
