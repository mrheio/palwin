import 'package:noctur/common/errors/err.dart';
import 'package:noctur/common/utils/status_codes.dart';

import '../../game/game.dart';

class TooManyRequests extends Err {
  const TooManyRequests()
      : super(
            name: 'too-many-requests',
            message: 'Ai incercat de prea multe ori. Incearca mai tarziu.',
            statusCode: StatusCode.badRequest);
}

class CapacityOverflow extends Err {
  CapacityOverflow(Game game)
      : super(
          name: 'game-capacity-overflow',
          message:
              'Jocul ${game.name} are echipe de maxim ${game.capacity} jucatori',
          statusCode: StatusCode.badRequest,
        );
}
