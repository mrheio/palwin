import 'package:noctur/common/exceptions/custom_exception.dart';
import 'package:noctur/common/success.dart';

abstract class AsyncStatus {
  const AsyncStatus();
}

class NormalStatus implements AsyncStatus {
  const NormalStatus();
}

class LoadingStatus implements AsyncStatus {
  const LoadingStatus();
}

class SuccessStatus implements AsyncStatus {
  final Success success;

  const SuccessStatus([this.success = Success.empty]);
}

class FailStatus implements AsyncStatus {
  final CustomException error;

  const FailStatus(this.error);
}
