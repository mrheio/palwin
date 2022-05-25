import 'package:noctur/common/database/base_repository.dart';
import 'package:noctur/common/database/database_service.dart';
import 'package:noctur/user/user.dart';

import '../common/database/query_filters.dart';

class UserRepository extends BaseRepository<User> {
  const UserRepository(DatabaseService<User> databaseService)
      : super(databaseService);

  Stream<List<User>> getByIds$(List<String> ids) {
    return databaseService.getWhere$(
        [Where(key: 'id', condition: WhereCondition.whereIn, value: ids)]);
  }
}
