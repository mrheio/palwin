import 'package:noctur/common/database/serializable.dart';
import 'package:noctur/common/utils/helpers.dart';

class Game extends Serializable {
  final String name;
  final int capacity;

  Game({String? id, required this.name, required this.capacity})
      : super(id ?? replaceSpacesWithUnderscores(name));

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'],
      name: map['name'],
      capacity: map['capacity'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'capacity': capacity,
    };
  }

  static String toId(String name) => replaceSpacesWithUnderscores(name);
  static String toName(String id) => replaceUnderscoresWithSpaces(id);

  @override
  List<Object?> get props => [id, name, capacity];
}
