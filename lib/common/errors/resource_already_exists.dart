import '../../game/game.dart';
import '../../team/team.dart';
import '../utils/status_codes.dart';
import 'err.dart';

abstract class ResourceAlreadyExists extends Err {
  const ResourceAlreadyExists({
    required String name,
    required String message,
  }) : super(name: name, message: message, statusCode: StatusCode.conflict);
}

class UserAlreadyExists extends ResourceAlreadyExists {
  const UserAlreadyExists()
      : super(
            name: 'user-already-exists',
            message: 'Un user cu aceste date exista deja');
}

class TeamAlreadyExists extends ResourceAlreadyExists {
  TeamAlreadyExists(Team team)
      : super(
            name: 'team-already-exists',
            message: 'Ai deja o echipa pentru jocul ${team.game}');
}

class GameAlreadyExists extends ResourceAlreadyExists {
  GameAlreadyExists(Game game)
      : super(
            name: 'game-already-exists',
            message: 'Jocul ${game.name} exista deja');
}
