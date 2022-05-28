import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/providers.dart';
import '../user/user_providers.dart';
import 'auth_service.dart';
import 'auth_state.dart';
import 'google_auth_service.dart';

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

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthNotifier(authService)..getLoggedUser();
});
