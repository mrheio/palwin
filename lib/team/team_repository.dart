import '../common/database/base_repository.dart';
import '../common/database/database_service.dart';
import '../common/database/query_filters.dart';
import 'team.dart';

class TeamRepository extends BaseRepository<Team> {
  const TeamRepository(DatabaseService<Team> databaseService)
      : super(databaseService);

  Future<void> deleteByGame(String game) async {
    databaseService.deleteWhere([
      Where(
        key: 'game',
        condition: WhereCondition.equalsTo,
        value: game,
      )
    ]);
  }
}
