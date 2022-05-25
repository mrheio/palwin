import 'package:noctur/common/database/base_repository.dart';
import 'package:noctur/common/database/database_service.dart';
import 'package:noctur/common/database/query_filters.dart';
import 'package:noctur/team/team.dart';

class TeamRepository extends BaseRepository<Team> {
  const TeamRepository(DatabaseService<Team> databaseService)
      : super(databaseService);

  Future<void> deleteByGame(String game) async {
    databaseService.deleteWhere(
        [Where(key: 'game', condition: WhereCondition.equalsTo, value: game)]);
  }
}
