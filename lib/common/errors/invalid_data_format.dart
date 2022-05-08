import 'package:noctur/common/errors/err.dart';
import 'package:noctur/common/utils/status_codes.dart';

abstract class InvalidDataFormat extends Err {
  const InvalidDataFormat({
    required String name,
    required String message,
  }) : super(
            name: name, message: message, statusCode: StatusCode.unprocessable);
}

class EmptyField extends InvalidDataFormat {
  const EmptyField() : super(name: 'empty-field', message: 'Camp obligatoriu');
}

class InvalidEmailFormat extends InvalidDataFormat {
  const InvalidEmailFormat()
      : super(name: 'invalid-email-format', message: 'Email invalid');
}

class NotNumber extends InvalidDataFormat {
  const NotNumber()
      : super(name: 'not-number', message: 'Valoarea trebuie sa fie numar');
}

class WeakPassword extends InvalidDataFormat {
  const WeakPassword()
      : super(name: 'weak-password', message: 'Parola prea slaba');
}
