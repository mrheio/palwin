import 'package:rxdart/rxdart.dart';

import '../auth/auth_service.dart';
import '../common/database/base_service.dart';
import '../common/errors/other_error.dart';
import '../game/game_repository.dart';
import '../user/user.dart';
import '../user/user_repository.dart';
import 'team.dart';
import 'team_repository.dart';

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
    if (data.slots > game.teamSize) {
      throw TeamSizeOverflow(game);
    }

    final user = (await _authService.getLoggedUser())!;
    final team = data.copyWith(uid: user.id, playersIds: [user.id]);

    return super.add(team);
  }

  Future<void> _addUserToTeam(User user, Team team) async {
    await repository.update(team.id, team.addUser(user));
  }

  Future<void> addLoggedUserToTeam(Team team) async {
    final user = (await _authService.getLoggedUser())!;
    await _addUserToTeam(user, team);
  }

  Future<void> _removeUserFromTeam(User user, Team team) async {
    await repository.update(team.id, team.removeUser(user));
  }

  Future<void> removeLoggedUserFromTeam(Team team) async {
    final user = (await _authService.getLoggedUser())!;
    await _removeUserFromTeam(user, team);
  }

  Future<void> deleteByGame(String game) async {
    repository.deleteByGame(game);
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
