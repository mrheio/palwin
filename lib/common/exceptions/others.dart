import '../../game/logic/game.dart';
import '../utils/status_codes.dart';
import 'custom_exception.dart';

class TooManyRequests extends CustomException {
  const TooManyRequests()
      : super(
            name: 'too-many-requests',
            message: 'Ai incercat de prea multe ori. Incearca mai tarziu.',
            statusCode: StatusCode.badRequest);
}

class GameTeamSizeOverflow extends CustomException {
  GameTeamSizeOverflow(Game game)
      : super(
          name: 'game-team-size-overflow',
          message:
              'Jocul *${game.name}* poate avea echipe de maxim *${game.teamSize}* jucatori',
          statusCode: StatusCode.badRequest,
        );
}

class TeamSizeTooSmall extends CustomException {
  const TeamSizeTooSmall()
      : super(
          name: 'team-size-too-small',
          message: 'Nu poti forma echipe cu mai putin de 2 jucatori',
          statusCode: StatusCode.badRequest,
        );
}

class NetworkTimeout extends CustomException {
  const NetworkTimeout()
      : super(
            name: 'network-timeout',
            message: 'A aparut o problema la conectate',
            statusCode: StatusCode.badRequest);
}

class UsernameAlreadyUsed extends CustomException {
  const UsernameAlreadyUsed()
      : super(
          name: 'username-already-used',
          message: 'Username-ul este deja folosit',
          statusCode: StatusCode.badRequest,
        );
}
