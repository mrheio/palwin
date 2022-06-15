import 'package:noctur/acccount/logic/auth_service.dart';
import 'package:noctur/common/database/base_repository.dart';
import 'package:noctur/common/database/query_helpers.dart';
import 'package:noctur/common/exceptions/others.dart';
import 'package:noctur/common/exceptions/resource_already_exists.dart';
import 'package:noctur/game/logic/game.dart';
import 'package:noctur/team/logic/message.dart';
import 'package:noctur/team/logic/team.dart';
import 'package:noctur/user/logic/user.dart';
import 'package:optional/optional.dart';
import 'package:rxdart/rxdart.dart';

class TeamsService {
  final BaseRepository<Team> _repository;
  final BaseRepository<SimpleUser> Function(String) _teamUsersRepository;
  final BaseRepository<Message> Function(String) _teamMessagesRepository;
  final AuthService _authService;

  TeamsService(this._repository, this._teamUsersRepository,
      this._teamMessagesRepository, this._authService);

  Future<List<Team>> getAll() async {
    final teamsRes = await _repository.getAll();
    return Future.wait(teamsRes.map((e) async {
      final users = await _teamUsersRepository(e.id).getAll();
      return e.copyWith(users: users);
    }));
  }

  Stream<List<Team>> getAll$() {
    return _repository.getAll$().switchMap((value) {
      return CombineLatestStream.list(value.map((e) {
        final users$ = _teamUsersRepository(e.id).getAll$();
        return users$.map((event) => e.copyWith(users: event));
      }));
    });
  }

  Stream<Optional<Team>> getById$(String id) {
    return _repository.getById$(id).switchMap((maybeTeam) async* {
      if (!maybeTeam.isPresent) {
        yield const Optional.empty();
        return;
      }
      final team = maybeTeam.value;
      final users$ = _teamUsersRepository(team.id).getAll$();
      yield* users$.map((users) => Optional.of(team.copyWith(users: users)));
    });
  }

  Future<List<Team>> getTeamsWithUserIn(SimpleUser user) async {
    var res = <Team>[];
    final teams = await getAll();
    for (final team in teams) {
      final userRes = await _teamUsersRepository(team.id).getById(user.id);
      if (userRes.isPresent) {
        res = [...res, team];
      }
    }
    return res;
  }

  Stream<List<Team>> getTeamsWithUserIn$(SimpleUser user) {
    return getAll$().map((event) => event
        .where((element) => element.users.any((e) => e.id == user.id))
        .toList());
  }

  Future<void> addFromForm({
    required String name,
    required String slots,
    required String description,
    required Game game,
  }) async {
    final parsedSlots = int.parse(slots);

    if (parsedSlots < 2) {
      throw const TeamSizeTooSmall();
    }

    if (parsedSlots > game.teamSize) {
      throw GameTeamSizeOverflow(game);
    }

    final user = (await _authService.getUser()).value;
    final team = Team(
      name: name,
      gameId: game.id,
      description: description,
      uid: user.id,
      slots: parsedSlots,
      freeSlots: parsedSlots - 1,
      filledSlots: 1,
    );

    try {
      await _repository.add(team);
      await _teamUsersRepository(team.id).add(user.toUser());
    } on ResourceAlreadyExists {
      throw TeamAlreadyExists(team);
    }
  }

  Future<void> updateTeam(
    Team team, {
    SimpleUser? removeUser,
    SimpleUser? addUser,
    bool updateUsers = false,
  }) async {
    if (removeUser != null) {
      await _teamUsersRepository(team.id)
          .deleteWhere(QueryFilter().equalsTo(key: 'id', value: removeUser.id));
    }

    if (addUser != null) {
      await _teamUsersRepository(team.id).add(addUser.toUser());
    }

    if (updateUsers) {
      for (final user in team.users) {
        await _teamUsersRepository(team.id).update(user.toUser());
        final userMessagesQuery =
            QueryFilter().equalsTo(key: 'user.id', value: user.id);
        final messagesRes =
            await _teamMessagesRepository(team.id).getWhere(userMessagesQuery);
        for (final message in messagesRes) {
          final newMessage = message.copyWith(user: user);
          await _teamMessagesRepository(team.id).update(newMessage);
        }
      }
    }

    await _repository.update(team);
  }

  Future<void> joinTeam(Team team) async {
    final user = (await _authService.getUser()).value;
    await updateTeam(team.addUser(user), addUser: user);
  }

  Future<void> quitTeam(Team team) async {
    final user = (await _authService.getUser()).value;
    await updateTeam(team.removeUser(user), removeUser: user);
  }

  Future<void> deleteTeam(Team team) async {
    await _teamMessagesRepository(team.id).deleteAll();
    await _teamUsersRepository(team.id).deleteAll();
    await _repository.deleteById(team.id);
  }

  Future<void> deleteWhere(QueryFilter filter) async {
    final teams = await _repository.getWhere(filter);
    for (final team in teams) {
      await deleteTeam(team);
    }
  }

  Future<void> sendMessage(Team team, String text) async {
    final user = (await _authService.getUser()).value;
    final message = Message(
      text: text,
      user: user.toUser(),
    );
    await _teamMessagesRepository(team.id).add(message);
  }
}
