import '../../game/logic/game.dart';
import '../../team/logic/team.dart';
import '../utils/status_codes.dart';
import 'custom_exception.dart';

class ResourceAlreadyExists extends CustomException {
  const ResourceAlreadyExists({
    String name = 'resource-already-exists',
    String message = 'A resource already exists',
  }) : super(name: name, message: message, statusCode: StatusCode.conflict);
}

class UserAlreadyExists extends ResourceAlreadyExists {
  const UserAlreadyExists()
      : super(
          name: 'user-already-exists',
          message: 'Un user cu aceste date exista deja',
        );
}

class TeamAlreadyExists extends ResourceAlreadyExists {
  TeamAlreadyExists(Team team)
      : super(
          name: 'team-already-exists',
          message: 'Ai deja o echipa pentru jocul ${Game.toName(team.gameId)}',
        );
}

class GameAlreadyExists extends ResourceAlreadyExists {
  GameAlreadyExists(Game game)
      : super(
          name: 'game-already-exists',
          message: 'Jocul ${game.name} exista deja',
        );
}
