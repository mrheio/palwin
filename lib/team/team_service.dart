import 'package:noctur/auth/auth_service.dart';
import 'package:noctur/common/database/base_service.dart';
import 'package:noctur/common/errors/other_error.dart';
import 'package:noctur/game/game_repository.dart';
import 'package:noctur/team/team.dart';
import 'package:noctur/team/team_repository.dart';
import 'package:noctur/user/user_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../common/database/query_filters.dart';
import '../user/user.dart';

class TeamService extends BaseService<Team, TeamRepository> {
  final GameRepository _gameRepository;
  final UserRepository _userRepository;
  final AuthService _authService;

  const TeamService(TeamRepository teamRepository, this._gameRepository,
      this._userRepository, this._authService)
      : super(teamRepository);

  @override
  Future<void> add(Team data) async {
    final game = (await _gameRepository.getByName(data.game))!;
    if (data.capacity > game.capacity) {
      throw CapacityOverflow(game);
    }
    final user = (await _authService.getLoggedUser())!;
    final team = data.copyWith(uid: user.id, playersIds: [user.id]);
    return super.add(team);
  }

  Future<void> addUserToTeam(User user, Team team) async {
    await repository.update(
        team.id, team.copyWith(playersIds: [...team.playersIds, user.id]));
  }

  Future<void> addLoggedUserToTeam(Team team) async {
    final user = (await _authService.getLoggedUser())!;
    await addUserToTeam(user, team);
  }

  Future<void> removeUserFromTeam(User user, Team team) async {
    await repository.update(
        team.id,
        team.copyWith(
            playersIds: team.playersIds
              ..removeWhere((element) => element == user.id)));
  }

  Future<void> removeLoggedUserFromTeam(Team team) async {
    final user = (await _authService.getLoggedUser())!;
    await removeUserFromTeam(user, team);
  }

  Future<void> deleteByGame(String game) async {
    repository.deleteWhere(
        [Where(key: 'game', condition: WhereCondition.equalsTo, value: game)]);
  }

  Stream<Team?> getTeamWithUsers$(String teamId) {
    return repository.getById$(teamId).switchMap(
      (team) async* {
        if (team != null) {
          final users$ = _userRepository.getByIds$(team.playersIds);
          yield* users$.map((users) => team.copyWith(users: users));
        }
        yield null;
      },
    );
  }
}
