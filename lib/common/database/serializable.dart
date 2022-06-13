import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:noctur/game/logic/logic.dart';
import 'package:noctur/team/logic/logic.dart';
import 'package:noctur/team/logic/message.dart';
import 'package:noctur/user/logic/logic.dart';

final _docDeserializers = {
  SimpleUser: (DocumentSnapshot<Map<String, dynamic>> doc) =>
      SimpleUser.fromDocument(doc),
  ComplexUser: (DocumentSnapshot<Map<String, dynamic>> doc) =>
      ComplexUser.fromDocument(doc),
  Team: (DocumentSnapshot<Map<String, dynamic>> doc) => Team.fromDocument(doc),
  Game: (DocumentSnapshot<Map<String, dynamic>> doc) => Game.fromDocument(doc),
  Message: (DocumentSnapshot<Map<String, dynamic>> doc) =>
      Message.fromDocument(doc),
};

abstract class Serializable<T> extends Equatable {
  final String id;
  final DateTime createdAt;

  Serializable({this.id = '', DateTime? createdAt})
      : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson();

  T copyWith({String? id, DateTime? createdAt});

  @override
  List<Object?> get props => [id];

  static G deserialize<G extends Serializable>(dynamic payload) {
    if (payload is DocumentSnapshot<Map<String, dynamic>>) {
      return _docDeserializers[G]!(payload) as G;
    }
    throw UnimplementedError();
  }
}
