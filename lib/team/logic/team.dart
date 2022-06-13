import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/database/serializable.dart';
import '../../../user/logic/logic.dart';

class Team extends Serializable<Team> {
  final String name;
  final String gameId;
  final String description;
  final String uid;
  final int slots;
  final int freeSlots;
  final int filledSlots;
  final List<SimpleUser> users;

  Team({
    String? id,
    required this.name,
    required this.gameId,
    required this.description,
    required this.uid,
    required this.slots,
    required this.freeSlots,
    required this.filledSlots,
    this.users = const [],
    DateTime? createdAt,
  }) : super(id: id ?? '$gameId--$uid', createdAt: createdAt);

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] as String,
      name: json['name'] as String,
      gameId: json['gameId'] as String,
      description: json['description'] as String,
      uid: json['uid'] as String,
      slots: json['slots'] as int,
      freeSlots: json['freeSlots'] as int,
      filledSlots: json['filledSlots'] as int,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
    );
  }

  factory Team.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Team.fromJson(data);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gameId': gameId,
      'description': description,
      'uid': uid,
      'slots': slots,
      'freeSlots': freeSlots,
      'filledSlots': filledSlots,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  @override
  Team copyWith({
    String? id,
    String? name,
    String? gameId,
    String? description,
    String? uid,
    int? slots,
    int? freeSlots,
    int? filledSlots,
    List<String>? playersIds,
    List<SimpleUser>? users,
    DateTime? createdAt,
  }) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      gameId: gameId ?? this.gameId,
      description: description ?? this.description,
      uid: uid ?? this.uid,
      slots: slots ?? this.slots,
      freeSlots: freeSlots ?? this.freeSlots,
      filledSlots: filledSlots ?? this.filledSlots,
      users: users ?? this.users,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isFull => freeSlots == 0;

  Team addUser(SimpleUser user) => copyWith(
      freeSlots: freeSlots - 1,
      filledSlots: filledSlots + 1,
      users: [...users, user.toUser()]);

  Team removeUser(SimpleUser user) => copyWith(
      freeSlots: freeSlots + 1,
      filledSlots: filledSlots - 1,
      users: users..removeWhere((element) => element.id == user.id));
}
