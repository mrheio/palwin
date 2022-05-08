import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/auth/google_auth_service.dart';
import 'package:noctur/common/providers.dart';
import 'package:noctur/user/user_providers.dart';

import 'auth_service.dart';
import 'auth_state.dart';

final authServiceProvider = Provider((ref) {
  final firebaseAuth = ref.read(firebaseAuthProvider);
  final userRepository = ref.read(userRepositoryProvider);
  return AuthService(firebaseAuth, userRepository);
});

final googleAuthServiceProvider = Provider((ref) {
  final firebaseAuth = ref.read(firebaseAuthProvider);
  final userRepository = ref.read(userRepositoryProvider);
  return GoogleAuthService(firebaseAuth, userRepository);
});

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthStateNotifier(authService)..getLoggedUser();
});
