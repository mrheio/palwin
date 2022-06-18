import 'package:cloud_firestore/cloud_firestore.dart';

import 'simple_user.dart';

class Friend extends SimpleUser {
  Friend({
    required String id,
    required String username,
    DateTime? createdAt,
  }) : super(id: id, username: username, createdAt: createdAt);

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'] as String,
      username: json['username'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
    );
  }

  factory Friend.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Friend.fromJson(data);
  }

  factory Friend.fromSimpleUser(SimpleUser user) {
    return Friend(
      id: user.id,
      username: user.username,
    );
  }
}
