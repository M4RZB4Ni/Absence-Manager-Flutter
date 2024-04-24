import 'package:freezed_annotation/freezed_annotation.dart';

import '../result/exception_handler.dart';

part 'result_state.freezed.dart';

@freezed
class ResultState<T> with _$ResultState<T> {
  const factory ResultState.idle() = Idle<T>;

  const factory ResultState.loading() = Loading;

  const factory ResultState.empty() = Empty;

  const factory ResultState.data({required final T data}) = Data<T>;

  const factory ResultState.error({ExceptionHandler? error}) = Error<T>;
}
