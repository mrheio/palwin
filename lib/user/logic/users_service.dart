import 'package:noctur/common/database/base_repository.dart';
import 'package:noctur/common/database/query_helpers.dart';
import 'package:noctur/common/exceptions/others.dart';
import 'package:noctur/team/logic/logic.dart';
import 'package:noctur/user/logic/simple_user.dart';
import 'package:optional/optional.dart';
import 'package:rxdart/rxdart.dart';

import 'complex_user.dart';
import 'friend.dart';

class UsersService {
  final BaseRepository<ComplexUser> _repository;
  final BaseRepository<Friend> Function(String) _friendsRepository;
  final TeamsService _teamsService;

  UsersService(this._repository, this._friendsRepository, this._teamsService);

  Future<List<Friend>> getFriends(SimpleUser user) {
    return _friendsRepository(user.id).getAll();
  }

  Stream<List<Friend>> getFriends$(SimpleUser user) {
    return _friendsRepository(user.id).getAll$();
  }

  Future<Optional<ComplexUser>> getById(String id) async {
    final maybeUser = await _repository.getById(id);
    if (maybeUser.isPresent) {
      final friends = await getFriends(maybeUser.value);
      final user = maybeUser.value;
      return Optional.of(user.copyWith(friends: friends));
    }
    return const Optional.empty();
  }

  Stream<Optional<ComplexUser>> getById$(String id) {
    return _repository.getById$(id).switchMap((maybeUser) async* {
      if (maybeUser.isPresent) {
        final user = maybeUser.value;
        yield* getFriends$(user)
            .map((event) => Optional.of(user.copyWith(friends: event)));
        return;
      }
      yield const Optional.empty();
    });
  }

  Future<void> add(ComplexUser user) async {
    final res = await _repository.getWhere(
        QueryFilter().equalsTo(key: 'username', value: user.username));
    if (res.isNotEmpty) {
      throw const UsernameAlreadyUsed();
    }
    await _repository.add(user);
  }

  Future<void> addFriend(SimpleUser user, Friend friend) async {
    await _friendsRepository(user.id).add(friend);
  }

  Future<void> deleteFriend(SimpleUser user, SimpleUser friend) async {
    await _friendsRepository(user.id).deleteById(friend.id);
  }

  Future<void> update(ComplexUser user) async {
    await _repository.update(user);
    final teams = await _teamsService.getTeamsWithUserIn(user);
    for (final team in teams) {
      await _teamsService.updateTeam(team.updateUser(user.toSimpleUser()),
          updateUsers: true);
    }
  }
}
