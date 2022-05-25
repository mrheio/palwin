import 'package:noctur/common/database/serializable.dart';
import 'package:noctur/game/game.dart';
import 'package:noctur/user/user.dart';

class Team extends Serializable {
  final String name;
  final String game;
  final String description;
  final String uid;
  final int capacity;
  final List<String> playersIds;
  final List<User> users;

  Team({
    String? id,
    required this.name,
    required this.game,
    required this.description,
    required this.uid,
    required this.capacity,
    List<String>? playersIds,
    this.users = const [],
  })  : playersIds = playersIds ?? [uid],
        super(id ?? '${Game.toId(game)}--$uid');

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'],
      name: map['name'],
      game: map['game'],
      description: map['description'],
      uid: map['uid'],
      capacity: map['capacity'] as int,
      playersIds: List<String>.from(map['playersIds']),
      users: const [],
    );
  }

  factory Team.fromForm({
    required String name,
    required String capacity,
    required String description,
    required Game game,
  }) {
    return Team(
      name: name,
      game: game.name,
      description: description,
      uid: '',
      capacity: int.parse(capacity),
      playersIds: const [],
      users: const [],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'game': game,
      'description': description,
      'uid': uid,
      'capacity': capacity,
      'playersIds': playersIds
    };
  }

  Team copyWith({
    String? id,
    String? name,
    String? game,
    String? description,
    int? capacity,
    String? uid,
    List<String>? playersIds,
    List<User>? users,
  }) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      game: game ?? this.game,
      description: description ?? this.description,
      uid: uid ?? this.uid,
      capacity: capacity ?? this.capacity,
      playersIds: playersIds ?? this.playersIds,
      users: users ?? this.users,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, game, description, uid, capacity, playersIds];

  bool hasUser(User user) {
    return playersIds.contains(user.id);
  }

  bool isOwnedBy(User user) {
    return uid == user.id;
  }

  bool isFull() {
    return playersIds.length == capacity;
  }
}
