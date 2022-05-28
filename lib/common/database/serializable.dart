import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../game/game.dart';
import '../../message/message.dart';
import '../../team/team.dart';
import '../../user/user.dart';

typedef Deserializer = Serializable Function(Map<String, dynamic>);

final Map<Type, Deserializer> deserializers = {
  User: (Map<String, dynamic> data) => User.fromMap(data),
  Team: (Map<String, dynamic> data) => Team.fromMap(data),
  Game: (Map<String, dynamic> data) => Game.fromMap(data),
  Message: (Map<String, dynamic> data) => Message.fromMap(data),
};

abstract class Serializable extends Equatable {
  final String id;

  const Serializable(this.id);

  Map<String, dynamic> toMap();

  static T deserializeDocument<T extends Serializable>(DocumentSnapshot doc) {
    return deserializers[T]!(doc.data() as Map<String, dynamic>) as T;
  }
}
