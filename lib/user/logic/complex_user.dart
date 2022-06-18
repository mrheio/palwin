import 'package:cloud_firestore/cloud_firestore.dart';

import 'friend.dart';
import 'simple_user.dart';

class ComplexUser extends SimpleUser {
  final String email;
  final Map<String, bool> roles;
  final List<Friend> friends;

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
    List<Friend>? friends,
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
  bool isFriendWith(SimpleUser user) =>
      friends.any((element) => element.id == user.id);

  @override
  List<Object?> get props => [id, username, email, roles, friends, createdAt];
}
