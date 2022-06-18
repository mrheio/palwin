import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:palwin/common/providers.dart';
import 'package:palwin/team/providers.dart';
import 'package:palwin/user/logic/logic.dart';

import '../acccount/providers.dart';
import '../common/utils.dart';

final usersRepositoryProvider = Provider((ref) {
  return ref
      .read(firestoreRepositoryFactoryProvider)
      .getRepository<ComplexUser>();
});

final usersFriendsRepositoryProvider = Provider.family((ref, String userId) {
  return ref
      .read(firestoreRepositoryFactoryProvider)
      .fromDocument<ComplexUser>(userId)
      .getRepository<Friend>();
});

final accountPagesStateProvider = createPagesStateProvider();

final usersServiceProvider = Provider((ref) {
  final usersRepository = ref.read(usersRepositoryProvider);
  usersFriendsRepository(String userId) =>
      ref.read(usersFriendsRepositoryProvider(userId));
  final teamsService = ref.read(teamsServiceProvider);
  return UsersService(usersRepository, usersFriendsRepository, teamsService);
});

final accountStateProvider =
    StateNotifierProvider.autoDispose<AccountNotifier, AsyncStatus>((ref) {
  final authService = ref.watch(authServiceProvider);
  final usersService = ref.read(usersServiceProvider);
  return AccountNotifier(authService, usersService);
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
