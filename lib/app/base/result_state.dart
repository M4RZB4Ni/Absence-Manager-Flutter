import 'package:freezed_annotation/freezed_annotation.dart';

import '../result/exception_handler.dart';

part 'result_state.freezed.dart';

/// Represents the state of an asynchronous operation with a result.
@freezed
class ResultState<T> with _$ResultState<T> {
  /// Represents the idle state (no data or error).
  const factory ResultState.idle() = Idle<T>;

  /// Represents the loading state (operation in progress).
  const factory ResultState.loading() = Loading;

  /// Represents the empty state (no data available).
  const factory ResultState.empty() = Empty;

  /// Represents the data state with the provided data.
  const factory ResultState.data({required final T data}) = Data<T>;

  /// Represents the error state with an optional [ExceptionHandler].
  const factory ResultState.error({ExceptionHandler? error}) = Error<T>;
}

