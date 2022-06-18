import 'package:noctur/user/logic/logic.dart';

class TeamMember extends SimpleUser {
  TeamMember({
    required String id,
    required String username,
    DateTime? createdAt,
  }) : super(id: id, username: username, createdAt: createdAt);

  factory TeamMember.fromSimpleUser(SimpleUser user) {
    return TeamMember(id: user.id, username: user.username);
  }
}
