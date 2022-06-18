import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/providers.dart';
import 'package:noctur/common/utils/pages_controller.dart';
import 'package:noctur/team/providers.dart';
import 'package:noctur/user/logic/logic.dart';

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
