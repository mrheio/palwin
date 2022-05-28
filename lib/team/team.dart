import '../common/database/serializable.dart';
import '../game/game.dart';
import '../user/user.dart';

class Team extends Serializable {
  final String name;
  final String gameId;
  final String description;
  final String uid;
  final int slots;
  final int freeSlots;
  final int filledSlots;
  final List<String> playersIds;
  final List<User> users;

  const Team({
    required this.name,
    required this.gameId,
    required this.description,
    required this.uid,
    required this.slots,
    required this.freeSlots,
    required this.filledSlots,
    required this.playersIds,
    this.users = const [],
  }) : super('$gameId--$uid');

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      name: map['name'],
      gameId: map['gameId'],
      description: map['description'],
      uid: map['uid'],
      slots: map['slots'] as int,
      freeSlots: map['freeSlots'] as int,
      filledSlots: map['filledSlots'] as int,
      playersIds: List<String>.from(map['playersIds']),
      users: const [],
    );
  }

  factory Team.fromForm({
    required String name,
    required Game game,
    required String description,
    required String slots,
  }) {
    return Team(
      name: name,
      gameId: game.id,
      description: description,
      uid: '',
      slots: int.parse(slots),
      freeSlots: int.parse(slots) - 1,
      filledSlots: 1,
      playersIds: const [],
      users: const [],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gameId': gameId,
      'description': description,
      'uid': uid,
      'slots': slots,
      'freeSlots': freeSlots,
      'filledSlots': filledSlots,
      'playersIds': playersIds
    };
  }

  Team copyWith({
    String? name,
    String? gameId,
    String? description,
    String? uid,
    int? slots,
    int? freeSlots,
    int? filledSlots,
    List<String>? playersIds,
    List<User>? users,
  }) {
    return Team(
      name: name ?? this.name,
      gameId: gameId ?? this.gameId,
      description: description ?? this.description,
      uid: uid ?? this.uid,
      slots: slots ?? this.slots,
      freeSlots: freeSlots ?? this.freeSlots,
      filledSlots: filledSlots ?? this.filledSlots,
      playersIds: playersIds ?? this.playersIds,
      users: users ?? this.users,
    );
  }

  String get game => Game.toName(gameId);

  @override
  List<Object?> get props => [id, name, gameId];

  bool hasUser(User user) {
    return playersIds.contains(user.id);
  }

  bool isOwnedBy(User user) {
    return uid == user.id;
  }

  bool isFull() {
    return slots == filledSlots;
  }

  Team addUser(User user) {
    return copyWith(
      playersIds: [...playersIds, user.id],
      filledSlots: filledSlots + 1,
      freeSlots: freeSlots - 1,
    );
  }

  Team removeUser(User user) {
    return copyWith(
      playersIds: playersIds..removeWhere((element) => element == user.id),
      filledSlots: filledSlots - 1,
      freeSlots: freeSlots + 1,
    );
  }
}
