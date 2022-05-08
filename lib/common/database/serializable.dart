import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:noctur/user/user.dart';

typedef Deserializer = Serializable Function(Map<String, dynamic>);

final Map<Type, Deserializer> deserializers = {
  User: (Map<String, dynamic> data) => User.fromMap(data)
};

abstract class Serializable extends Equatable {
  final String id;

  const Serializable(this.id);

  Map<String, dynamic> toMap();

  static T deserializeDocument<T extends Serializable>(DocumentSnapshot doc) {
    return deserializers[T]!(doc.data() as Map<String, dynamic>) as T;
  }
}
