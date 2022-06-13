import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PagesState {
  final PageController controller = PageController();

  void dispose() {
    controller.dispose();
  }

  Future<void> toPage(int index) async {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  Future<void> toInitPage() async {
    toPage(0);
  }
}

AutoDisposeProvider<PagesState> createPagesStateProvider() =>
    Provider.autoDispose<PagesState>((ref) {
      final state = PagesState();
      ref.onDispose(() {
        state.dispose();
      });
      return state;
    });
