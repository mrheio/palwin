import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noctur/common/providers.dart';
import 'package:noctur/user/logic/logic.dart';

final usersRepositoryProvider = Provider((ref) {
  return ref
      .read(firestoreRepositoryFactoryProvider)
      .getRepository<ComplexUser>();
});
