import 'package:noctur/common/errors/err.dart';
import 'package:noctur/common/utils/status_codes.dart';

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
  const TeamAlreadyExists(String game)
      : super(
            name: 'team-already-exists',
            message: 'Ai deja o echipa pentru jocul $game');
}

class GameAlreadyExists extends ResourceAlreadyExists {
  const GameAlreadyExists(String game)
      : super(name: 'game-already-exists', message: 'Jocul $game exista deja');
}
