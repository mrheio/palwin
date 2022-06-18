import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:palwin/team/logic/logic.dart';

import '../../common/database.dart';

class SimpleUser extends Serializable<SimpleUser> {
  final String username;

  SimpleUser({
    required String id,
    required this.username,
    DateTime? createdAt,
  }) : super(id: id, createdAt: createdAt);

  factory SimpleUser.fromJson(Map<String, dynamic> json) {
    return SimpleUser(
      id: json['id'] as String,
      username: json['username'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
    );
  }

  factory SimpleUser.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return SimpleUser.fromJson(data);
  }

  @override
  List<Object?> get props => [id, username, createdAt];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  @override
  SimpleUser copyWith({String? id, String? username, DateTime? createdAt}) {
    return SimpleUser(
      id: id ?? this.id,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  SimpleUser toSimpleUser() =>
      SimpleUser(id: id, username: username, createdAt: createdAt);

  bool isInTeam(Team team) => team.users.any((element) => element.id == id);
  bool ownsTeam(Team team) => team.uid == id;
}
