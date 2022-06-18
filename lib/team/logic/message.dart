import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:noctur/common/database.dart';
import 'package:noctur/user/logic/logic.dart';

class Message extends Serializable<Message> {
  final String text;
  final SimpleUser user;

  Message({
    String? id,
    required this.text,
    required this.user,
    DateTime? createdAt,
  }) : super(id: id ?? '', createdAt: createdAt);

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      text: json['text'] as String,
      user: SimpleUser.fromJson(Map<String, dynamic>.from(json['user'])),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt'] as int),
    );
  }

  factory Message.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return Message.fromJson(data);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'user': user.toJson(),
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  @override
  Message copyWith({
    String? id,
    String? text,
    SimpleUser? user,
    DateTime? createdAt,
  }) {
    return Message(
      id: id ?? this.id,
      text: text ?? this.text,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
