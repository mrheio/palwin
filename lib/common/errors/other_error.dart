import '../../game/game.dart';
import '../utils/status_codes.dart';
import 'err.dart';

class TooManyRequests extends Err {
  const TooManyRequests()
      : super(
            name: 'too-many-requests',
            message: 'Ai incercat de prea multe ori. Incearca mai tarziu.',
            statusCode: StatusCode.badRequest);
}

class TeamSizeOverflow extends Err {
  TeamSizeOverflow(Game game)
      : super(
          name: 'game-capacity-overflow',
          message:
              'Jocul ${game.name} are echipe de maxim ${game.teamSize} jucatori',
          statusCode: StatusCode.badRequest,
        );
}
