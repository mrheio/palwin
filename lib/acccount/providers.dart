import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/providers.dart';
import 'package:noctur/common/utils.dart';
import 'package:noctur/user/providers.dart';

import 'logic/logic.dart';

final authServiceProvider = Provider((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final usersService = ref.read(usersServiceProvider);
  return AuthService(auth, usersService);
});

final entryPagesProvider = createPagesStateProvider();

final authStateProvider =
    StateNotifierProvider.autoDispose<AuthNotifier, AuthState>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthNotifier(authService)..getUser();
});

final authEffectProvider =
    Provider.family.autoDispose((ref, BuildContext context) {
  ref.listen<AuthState>(authStateProvider, (previous, next) {
    final status = next.status;
    if (status is FailStatus) {
      StyledSnackbar.fromException(status.error).show(context);
    }
    if (status is SuccessStatus) {
      StyledSnackbar.fromSuccess(status.success).show(context);
    }
  });
});

final accountStateProvider =
    StateNotifierProvider.autoDispose<AccountNotifier, AsyncStatus>((ref) {
  final user = ref.watch(authStateProvider.select((value) => value.user))!;
  final usersService = ref.read(usersServiceProvider);
  return AccountNotifier(user, usersService);
});

final accountEffectProvider =
    Provider.family.autoDispose((ref, BuildContext context) {
  ref.listen<AsyncStatus>(accountStateProvider, (previous, next) {
    if (next is FailStatus) {
      StyledSnackbar.fromException(next.error).show(context);
    }
    if (next is SuccessStatus) {
      StyledSnackbar.fromSuccess(next.success).show(context);
    }
  });
});
