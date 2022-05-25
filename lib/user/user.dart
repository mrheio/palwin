import 'package:noctur/common/database/serializable.dart';

class User extends Serializable {
  final String email;
  final String username;
  final Map<String, bool> roles;

  const User({
    required String id,
    required this.email,
    required this.username,
    this.roles = const {'admin': false},
  }) : super(id);

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      roles: Map<String, bool>.from(map['roles']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'roles': roles,
    };
  }

  User copyWith({String? email, String? username, Map<String, bool>? roles}) {
    return User(
      id: id,
      email: email ?? this.email,
      username: username ?? this.username,
      roles: roles ?? this.roles,
    );
  }

  @override
  List<Object?> get props => [id, email, username, roles];
}
