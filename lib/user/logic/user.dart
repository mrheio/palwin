import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noctur/team/logic/logic.dart';

import '../../common/database/serializable.dart';

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
  List<Object?> get props => [id];

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

  SimpleUser toUser() =>
      SimpleUser(id: id, username: username, createdAt: createdAt);

  bool isInTeam(Team team) => team.users.any((element) => element.id == id);
  bool ownsTeam(Team team) => team.uid == id;
}

class ComplexUser extends SimpleUser {
  final String email;
  final Map<String, bool> roles;
  final List<SimpleUser> friends;

  ComplexUser({
    required String id,
    required String username,
    required this.email,
    this.roles = const {'admin': false},
    this.friends = const [],
    DateTime? createdAt,
  }) : super(id: id, username: username, createdAt: createdAt);

  factory ComplexUser.fromJson(Map<String, dynamic> json) {
    return ComplexUser(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      roles: Map<String, bool>.from(json['roles']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
    );
  }

  factory ComplexUser.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return ComplexUser.fromJson(data);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'roles': roles,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  @override
  ComplexUser copyWith({
    String? id,
    String? username,
    String? email,
    Map<String, bool>? roles,
    List<SimpleUser>? friends,
    DateTime? createdAt,
  }) {
    return ComplexUser(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      roles: roles ?? this.roles,
      friends: friends ?? this.friends,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  bool get isAdmin => roles['admin'] ?? false;
}
