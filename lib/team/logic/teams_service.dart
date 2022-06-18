import 'package:noctur/common/database.dart';
import 'package:noctur/common/exceptions.dart';
import 'package:noctur/game/logic/game.dart';
import 'package:noctur/team/logic/logic.dart';
import 'package:noctur/team/logic/message.dart';
import 'package:noctur/team/logic/team.dart';
import 'package:noctur/user/logic/logic.dart';
import 'package:noctur/user/logic/simple_user.dart';
import 'package:optional/optional.dart';
import 'package:rxdart/rxdart.dart';

class TeamsService {
  final BaseRepository<Team> _repository;
  final BaseRepository<SimpleUser> Function(String) _teamUsersRepository;
  final BaseRepository<Message> Function(String) _teamMessagesRepository;

  TeamsService(this._repository, this._teamUsersRepository,
      this._teamMessagesRepository);

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
      })).defaultIfEmpty([]);
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
      final messages$ = _teamMessagesRepository(team.id).getAll$();
      yield* CombineLatestStream.combine2(
        users$,
        messages$,
        (List<SimpleUser> a, List<Message> b) =>
            Optional.of(team.copyWith(users: a, messages: b)),
      );
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

  Stream<List<Team>> getWhere$({
    Game? game,
    bool freeSlots = false,
    SimpleUser? containsUser,
  }) {
    var queryFilter = QueryFilter();
    if (game != null) {
      queryFilter = queryFilter.equalsTo(key: 'gameId', value: game.id);
    }
    if (freeSlots) {
      queryFilter = queryFilter.isGreaterThan(key: 'freeSlots', value: 0);
    }
    final res = _repository.getWhere$(queryFilter).switchMap((value) {
      return CombineLatestStream.list(value.map((e) {
        final users$ = _teamUsersRepository(e.id).getAll$();
        return users$.map((event) => e.copyWith(users: event));
      })).defaultIfEmpty([]);
    });
    if (containsUser != null) {
      return res.map((event) => event
          .where((element) =>
              element.users.any((element) => element.id == containsUser.id))
          .toList());
    }
    return res;
  }

  Future<void> addFromForm({
    required String name,
    required String slots,
    required String description,
    required Game game,
    required SimpleUser user,
  }) async {
    final parsedSlots = int.parse(slots);

    if (parsedSlots < 2) {
      throw const TeamSizeTooSmall();
    }

    if (parsedSlots > game.teamSize) {
      throw GameTeamSizeOverflow(game);
    }

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
      await _teamUsersRepository(team.id).add(user);
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
      await _teamUsersRepository(team.id).add(addUser.toSimpleUser());
    }

    if (updateUsers) {
      for (final user in team.users) {
        await _teamUsersRepository(team.id).update(user);
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

  Future<void> addMember(SimpleUser user, Team team) async {
    await updateTeam(team.addUser(user), addUser: user);
  }

  Future<void> deleteMember(SimpleUser user, Team team) async {
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

  Future<void> addMessage(Message message, Team team) async {
    await _teamMessagesRepository(team.id).add(message);
  }
}
