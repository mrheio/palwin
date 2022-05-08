import 'package:noctur/common/errors/invalid_data_format.dart';

class Validator {
  const Validator._();

  static void required(String? value) {
    if (value == null || value.isEmpty) {
      throw const EmptyField();
    }
  }

  static void email(String? value) {
    if (value != null) {
      if (!RegExp(
              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
          .hasMatch(value)) {
        throw const InvalidEmailFormat();
      }
    }
  }

  static void numeric(String? value) {
    if (value != null) {
      if (double.tryParse(value) == null) {
        throw const NotNumber();
      }
    }
  }
}
