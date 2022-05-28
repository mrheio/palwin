import '../common/database/serializable.dart';

class Game extends Serializable {
  final String name;
  final int teamSize;

  Game({
    required this.name,
    required this.teamSize,
  }) : super(name.replaceAll(' ', '_'));

  factory Game.fromForm({required String name, required String teamSize}) {
    return Game(
      name: name,
      teamSize: int.parse(teamSize),
    );
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      name: map['name'],
      teamSize: map['teamSize'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'teamSize': teamSize,
    };
  }

  static String toId(String name) => name.replaceAll(' ', '_');
  static String toName(String id) => id.replaceAll('_', ' ');

  @override
  List<Object?> get props => [id, name, teamSize];
}
