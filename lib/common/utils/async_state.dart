import 'package:noctur/common/exceptions/custom_exception.dart';
import 'package:noctur/common/success.dart';
import 'package:optional/optional.dart';

abstract class AsyncStatus {
  final bool loading;
  final Optional<Success> success;
  final Optional<CustomException> error;

  const AsyncStatus({
    this.loading = false,
    this.success = const Optional.empty(),
    this.error = const Optional.empty(),
  });
}
