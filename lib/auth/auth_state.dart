import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:optional/optional.dart';

import '../user/user.dart';
import 'auth_service.dart';

class AuthState {
  final User? user;
  final bool loading;

  const AuthState({this.user, this.loading = false});

  AuthState copyWith({
    Optional<User>? user,
    bool? loading,
  }) {
    return AuthState(
      user: user != null ? user.orElseNull : this.user,
      loading: loading ?? this.loading,
    );
  }

  @override
  String toString() {
    return 'USER: [$user] | LOADING: [$loading]';
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  StreamSubscription? _streamSub;

  AuthNotifier(this._authService) : super(const AuthState());

  void getLoggedUser() {
    state = state.copyWith(loading: true);
    _streamSub = _authService.getLoggedUser$().listen((event) {
      state = state.copyWith(
        user: Optional.ofNullable(event),
        loading: false,
      );
    });
  }

  Future<void> logOut() async {
    state = state.copyWith(loading: true);
    await _authService.logOut();
  }

  @override
  void dispose() {
    _streamSub?.cancel();
    super.dispose();
  }
}
