import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/auth_providers.dart';
import 'package:noctur/auth/auth_service.dart';
import 'package:noctur/common/success.dart';
import 'package:noctur/message/message.dart';
import 'package:noctur/message/message_providers.dart';
import 'package:noctur/message/message_service.dart';
import 'package:optional/optional.dart';

void scrollToBottom(ScrollController scrollController) {
  scrollController.jumpTo(scrollController.position.maxScrollExtent);
}

class ChatState {
  final TextEditingController messageField;
  final List<Message> messages;
  final bool loading;
  final Success? success;
  final bool hasText;

  ChatState({
    TextEditingController? messageField,
    this.messages = const [],
    this.loading = false,
    this.success,
    this.hasText = false,
  }) : messageField = messageField ?? TextEditingController();

  void dispose() {
    messageField.dispose();
  }

  ChatState copyWith({
    List<Message>? messages,
    bool? loading,
    Optional<Success>? success,
    bool? hasText,
  }) {
    return ChatState(
      messageField: messageField,
      messages: messages ?? this.messages,
      loading: loading ?? this.loading,
      success: success != null ? success.orElseNull : this.success,
      hasText: hasText ?? this.hasText,
    );
  }
}

class ChatStateNotifier extends StateNotifier<ChatState> {
  final MessageService _messageService;
  final AuthService _authService;
  StreamSubscription? _streamSub;

  ChatStateNotifier(this._messageService, this._authService)
      : super(ChatState());

  void getMessages() {
    state = state.copyWith(loading: true);
    _streamSub = _messageService.getAll$().listen((event) {
      state = state.copyWith(messages: event, loading: false);
    });
  }

  void handleTextChange() {
    if (state.messageField.text.isNotEmpty) {
      state = state.copyWith(hasText: true);
      return;
    }
    state = state.copyWith(hasText: false);
  }

  Future<void> addMessage() async {
    final user = (await _authService.getLoggedUser())!;
    final text = state.messageField.text.trim();
    final message = Message(
        id: '',
        message: text,
        uid: user.id,
        createdAt: DateTime.now().millisecondsSinceEpoch);
    await _messageService.add(message);
    state =
        state.copyWith(success: Optional.of(const Success()), hasText: false);
    state.messageField.clear();
  }

  @override
  void dispose() {
    _streamSub?.cancel();
    super.dispose();
  }
}

final chatStateProvider = StateNotifierProvider.family
    .autoDispose<ChatStateNotifier, ChatState, String>((ref, teamId) {
  final messageService = ref.read(messageServiceProvider(teamId));
  final authService = ref.read(authServiceProvider);
  return ChatStateNotifier(messageService, authService)..getMessages();
});
