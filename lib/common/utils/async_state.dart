import 'package:noctur/common/exceptions/custom_exception.dart';
import 'package:noctur/common/success.dart';
import 'package:optional/optional.dart';

abstract class AsyncStatus {
  const factory AsyncStatus.normal() = AsyncNormal;
  const factory AsyncStatus.loading() = AsyncLoading;
  const factory AsyncStatus.success(Success success) = AsyncSuccess;
  const factory AsyncStatus.fail(CustomException error) = AsyncFail;
}

class AsyncNormal implements AsyncStatus {
  const AsyncNormal();
}

class AsyncLoading implements AsyncStatus {
  const AsyncLoading();
}

class AsyncSuccess implements AsyncStatus {
  final Success success;

  const AsyncSuccess([this.success = Success.empty]);
}

class AsyncFail implements AsyncStatus {
  final CustomException error;

  const AsyncFail(this.error);
}

class AsyncState<T> {
  final Optional<T> _data;
  final AsyncStatus status;

  AsyncState._({AsyncState<T>? prev, T? data, required this.status})
      : _data = data != null
            ? Optional.of(data)
            : prev != null
                ? prev._data
                : const Optional.empty();

  AsyncState.init([T? data])
      : _data = Optional.ofNullable(data),
        status = const AsyncStatus.normal();

  AsyncState<T> normal({AsyncState<T>? prev, T? data}) {
    return AsyncState._(
      prev: prev,
      data: data,
      status: const AsyncStatus.normal(),
    );
  }

  AsyncState<T> loading() {
    return AsyncState._(
      prev: this,
      status: const AsyncStatus.loading(),
    );
  }

  AsyncState<T> success({T? data, Success success = Success.empty}) {
    return AsyncState._(
      prev: this,
      data: data,
      status: AsyncStatus.success(success),
    );
  }

  AsyncState<T> fail({T? data, required CustomException error}) {
    return AsyncState._(
      prev: this,
      data: data,
      status: AsyncStatus.fail(error),
    );
  }

  bool get isLoading => status is AsyncLoading;
  bool get isSuccess => status is AsyncSuccess;
  Success get successRes => (status as AsyncSuccess).success;
  bool get isFail => status is AsyncFail;
  CustomException get errorRes => (status as AsyncFail).error;
  bool get hasData => _data.isPresent;
  T get data => _data.value;
}
