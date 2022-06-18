import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:palwin/game/logic/logic.dart';
import 'package:palwin/team/logic/logic.dart';
import 'package:palwin/user/logic/logic.dart';

abstract class Serializable<T> extends Equatable {
  final String id;
  final DateTime createdAt;

  Serializable({this.id = '', DateTime? createdAt})
      : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson();

  T copyWith({String? id, DateTime? createdAt});

  @override
  List<Object?> get props => [id, createdAt];

  static G deserialize<G extends Serializable>(dynamic payload) {
    if (payload is DocumentSnapshot<Map<String, dynamic>>) {
      switch (G) {
        case SimpleUser:
          return SimpleUser.fromDocument(payload) as G;
        case ComplexUser:
          return ComplexUser.fromDocument(payload) as G;
        case Game:
          return Game.fromDocument(payload) as G;
        case Team:
          return Team.fromDocument(payload) as G;
        case Message:
          return Message.fromDocument(payload) as G;
      }
    }
    throw UnimplementedError();
  }
}
