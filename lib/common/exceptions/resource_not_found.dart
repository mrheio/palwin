import '../utils/status_codes.dart';
import 'custom_exception.dart';

class ResourceNotFound extends CustomException {
  const ResourceNotFound({
    String name = 'resource-not-found',
    required String message,
  }) : super(
          name: name,
          message: message,
          statusCode: StatusCode.notFound,
        );
}

class UserNotFound extends ResourceNotFound {
  const UserNotFound()
      : super(
          name: 'user-not-found',
          message: 'Nu exista user cu aceste date',
        );
}

class GameNotFound extends ResourceNotFound {
  const GameNotFound(String game)
      : super(
          name: 'game-not-found',
          message: 'Jocul ${game} nu exista',
        );
}

class TeamNotFound extends ResourceNotFound {
  const TeamNotFound(String team)
      : super(
          name: 'team-not-found',
          message: 'Echipa ${team} nu exista',
        );
}
