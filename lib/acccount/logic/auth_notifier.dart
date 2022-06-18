import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/logic/auth_service.dart';
import 'package:noctur/common/utils.dart';
import 'package:noctur/user/logic/logic.dart';
import 'package:optional/optional.dart';

import '../../common/exceptions/auth_exception.dart';

class AuthState {
  final ComplexUser? user;
  final AsyncStatus status;

  const AuthState(this.user, {this.status = const NormalStatus()});

  bool get hasUser => user != null;

  AuthState copyWith({Optional<ComplexUser>? user, AsyncStatus? status}) {
    return AuthState(
      user != null ? user.orElseNull : this.user,
      status: status ?? this.status,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;
  StreamSubscription? _userSub;

  AuthNotifier(this._authService) : super(const AuthState(null));

  void getUser() {
    state = state.copyWith(status: const LoadingStatus());
    _userSub = _authService.getUser$().listen((event) {
      state = state.copyWith(user: event, status: const NormalStatus());
    });
  }

  Future<void> logIn(String email, String password) async {
    state = state.copyWith(status: const LoadingStatus());
    try {
      await _authService.logInWithEmailAndPassword(
          email: email, password: password);
    } on AuthException catch (error) {
      state = state.copyWith(status: FailStatus(error));
    }
  }

  Future<void> register(String email, String username, String password) async {
    state = state.copyWith(status: const LoadingStatus());
    try {
      await _authService.register(
          email: email, username: username, password: password);
    } on AuthException catch (error) {
      state = state.copyWith(status: FailStatus(error));
    }
  }

  Future<void> logOut() async {
    state = state.copyWith(status: const LoadingStatus());
    await _authService.logOut();
  }

  @override
  void dispose() {
    _userSub?.cancel();
    super.dispose();
  }
}
