import 'package:noctur/common/errors/err.dart';
import 'package:noctur/common/utils/status_codes.dart';

class TooManyRequests extends Err {
  const TooManyRequests()
      : super(
            name: 'too-many-requests',
            message: 'Ai incercat de prea multe ori. Incearca mai tarziu.',
            statusCode: StatusCode.badRequest);
}
