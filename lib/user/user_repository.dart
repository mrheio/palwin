import 'package:noctur/common/database/base_repository.dart';
import 'package:noctur/common/database/database_service.dart';
import 'package:noctur/user/user.dart';

class UserRepository extends BaseRepository<User> {
  const UserRepository(DatabaseService<User> databaseService)
      : super(databaseService);
}
