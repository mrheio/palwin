import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatState extends ChangeNotifier {
  final TextEditingController messageController = TextEditingController();
  bool hasMessageToSend = false;

  String get message => messageController.text.trim();

  void handleMessageInputChange(String val) {
    if (val.isNotEmpty && !hasMessageToSend) {
      hasMessageToSend = true;
      notifyListeners();
      return;
    }
    if (val.isEmpty && hasMessageToSend) {
      hasMessageToSend = false;
      notifyListeners();
      return;
    }
  }

  void clearController() {
    messageController.clear();
    hasMessageToSend = false;
    notifyListeners();
  }

  void disposeController() {
    messageController.dispose();
  }
}

final chatStateProvider = ChangeNotifierProvider.autoDispose((ref) {
  final chatState = ChatState();
  ref.onDispose(() {
    chatState.disposeController();
  });
  return chatState;
});
