typedef ValidatorHandler<T> = String? Function(T? val);

final _emailRegexp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
final _uppercaseRegexp = RegExp(r'[A-Z]');

class InputValidator<T> {
  final List<ValidatorHandler<T>> validators;

  const InputValidator([this.validators = const []]);

  InputValidator<T> _addValidator(ValidatorHandler<T> validator) {
    return InputValidator([...validators, validator]);
  }

  InputValidator<T> notEmpty([String message = 'Camp obligatoriu']) {
    return _addValidator((val) {
      if (val == null || (val is String && val.isEmpty)) {
        return message;
      }
      return null;
    });
  }

  InputValidator<T> email([String message = 'Email invalid']) {
    return _addValidator((val) {
      if (val is String) {
        if (!_emailRegexp.hasMatch(val)) {
          return message;
        }
      }
      return null;
    });
  }

  InputValidator<T> numeric([String message = 'Camp numeric']) {
    return _addValidator((val) {
      if (val is String) {
        if (double.tryParse(val) == null) {
          return message;
        }
      }
      return null;
    });
  }

  InputValidator<T> minLength(int minLength, [String message = '']) {
    return _addValidator((val) {
      if (val is String) {
        if (val.length < minLength) {
          return message.isNotEmpty ? message : 'Minim $minLength caractere';
        }
      }
      return null;
    });
  }

  InputValidator<T> maxLength(int maxLength, [String message = '']) {
    return _addValidator((val) {
      if (val is String) {
        if (val.length > maxLength) {
          return message.isNotEmpty ? message : 'Maxim $maxLength caractere';
        }
      }
      return null;
    });
  }

  InputValidator<T> numericMinValue(int minValue, [String message = '']) {
    return _addValidator((val) {
      if (val is String) {
        final number = double.tryParse(val);
        if (number == null) {
          return 'Camp numeric';
        }
        if (number < minValue) {
          return message.isNotEmpty ? message : 'Cel putin $minValue';
        }
      }
      return null;
    });
  }

  InputValidator<T> hasUppercase(
      [String message = 'Trebuie sa contina cel putin o majuscula']) {
    return _addValidator((val) {
      if (val is String) {
        if (!_uppercaseRegexp.hasMatch(val)) {
          return message;
        }
      }
      return null;
    });
  }

  ValidatorHandler<T> create() {
    return (T? value) {
      for (final validator in validators) {
        final res = validator(value);
        if (res != null) {
          return res;
        }
      }
      return null;
    };
  }
}
