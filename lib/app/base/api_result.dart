// Import necessary packages and files
import 'package:freezed_annotation/freezed_annotation.dart'; // Import the freezed_annotation package

import '../result/exception_handler.dart'; // Import the ExceptionHandler class for error handling

// Generate a part file using Freezed package.
part 'api_result.freezed.dart';

// Freezed annotation to create a union type for API results.
@freezed
class ApiResult<T> with _$ApiResult<T> {
  // Factory constructor for a successful API result.
  const factory ApiResult.success({required final T data}) = Success<T>;

  // Factory constructor for a failed API result.
  const factory ApiResult.failure({required final ExceptionHandler error}) =
  Failure<T>;
}
