import 'package:noctur/common/database/serializable.dart';

class Team extends Serializable {
  final String name;
  final String game;
  final String description;
  final String uid;
  final int capacity;
  final List<String> playersIds;

  const Team({
    String? id,
    required this.name,
    required this.game,
    required this.description,
    required this.uid,
    required this.capacity,
    required this.playersIds,
  }) : super(id ?? '$game--$uid');

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'],
      name: map['name'],
      game: map['game'],
      description: map['description'],
      uid: map['uid'],
      capacity: map['capacity'],
      playersIds: map['playersIds'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'game': this.game,
      'description': this.description,
      'uid': this.uid,
      'capacity': this.capacity,
      'playersIds': this.playersIds
    };
  }

  Team copyWith({
    String? name,
    String? game,
    String? description,
    int? capacity,
    List<String>? playersIds,
  }) {
    return Team(
      id: id,
      name: name ?? this.name,
      game: game ?? this.game,
      description: description ?? this.description,
      uid: uid,
      capacity: capacity ?? this.capacity,
      playersIds: playersIds ?? this.playersIds,
    );
  }

  @override
  List<Object?> get props =>
      [id, name, game, description, uid, capacity, playersIds];
}
