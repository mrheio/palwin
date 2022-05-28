import 'package:optional/optional.dart';

import '../common/database/serializable.dart';
import '../user/user.dart';

class Message extends Serializable {
  final String message;
  final String uid;
  final int createdAt;
  final Optional<User> user;

  const Message({
    required String id,
    required this.message,
    required this.uid,
    required this.createdAt,
    this.user = const Optional.empty(),
  }) : super(id);

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      message: map['message'],
      uid: map['uid'],
      createdAt: map['createdAt'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      "message": message,
      'uid': uid,
      'createdAt': createdAt,
    };
  }

  @override
  List<Object?> get props => [id, message, uid, createdAt];

  Message copyWith({
    String? id,
    String? message,
    String? uid,
    int? createdAt,
    Optional<User>? user,
  }) {
    return Message(
      id: id ?? this.id,
      message: message ?? this.message,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }
}
