import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/acccount/logic/account_service.dart';
import 'package:noctur/acccount/logic/auth_service.dart';
import 'package:noctur/common/providers.dart';
import 'package:noctur/common/utils/pages_controller.dart';
import 'package:noctur/team/providers.dart';
import 'package:noctur/user/providers.dart';

final authServiceProvider = Provider((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final usersRepository = ref.read(usersRepositoryProvider);
  return AuthService(auth, usersRepository);
});

final accountServiceProvider = Provider((ref) {
  final authService = ref.read(authServiceProvider);
  final usersRepository = ref.read(usersRepositoryProvider);
  final teamsService = ref.read(teamsServiceProvider);
  return AccountService(authService, usersRepository, teamsService);
});

final userProvider$ = StreamProvider((ref) {
  return ref.read(authServiceProvider).getUser$();
});

final entryPagesProvider = createPagesStateProvider();
