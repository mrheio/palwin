import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palwin/common/providers.dart';
import 'package:palwin/common/utils.dart';
import 'package:palwin/user/providers.dart';

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
