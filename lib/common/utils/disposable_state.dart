import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class DisposableState {
  void onDispose();
}

abstract class DisposableStateNotifier<T extends DisposableState>
    extends StateNotifier<T> {
  DisposableStateNotifier(T state) : super(state);

  @override
  void dispose() {
    state.onDispose();
    super.dispose();
  }
}
