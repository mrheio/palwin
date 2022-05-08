import 'package:noctur/common/database/base_service.dart';
import 'package:noctur/common/database/where.dart';
import 'package:noctur/team/team.dart';
import 'package:noctur/team/team_repository.dart';

class TeamService extends BaseService<Team> {
  const TeamService(TeamRepository teamRepository) : super(teamRepository);

  Future<void> deleteByGame(String game) async {
    repository.deleteWhere(
        [Where(key: 'game', condition: WhereCondition.equalsTo, value: game)]);
  }
}
