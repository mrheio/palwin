import 'package:noctur/acccount/logic/auth_service.dart';
import 'package:noctur/common/database/base_repository.dart';
import 'package:noctur/team/logic/teams_service.dart';
import 'package:noctur/user/logic/logic.dart';

class AccountService {
  final AuthService _authService;
  final BaseRepository<ComplexUser> _usersRepository;
  final TeamsService _teamsService;

  const AccountService(
      this._authService, this._usersRepository, this._teamsService);

  Future<void> updateUsername(String newUsername) async {
    final user = (await _authService.getUser()).value;
    final newUser = user.copyWith(username: newUsername);
    await _usersRepository.update(newUser);
    final teams = await _teamsService.getTeamsWithUserIn(user);
    for (final team in teams) {
      final newTeam = team.copyWith(
          users: [...team.users..removeWhere((e) => e.id == user.id), newUser]);
      _teamsService.updateTeam(newTeam, updateUsers: true);
    }
  }
}
