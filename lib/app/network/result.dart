import 'package:freezed_annotation/freezed_annotation.dart';

// Generate a part file using Freezed package.
part 'result.freezed.dart';
part 'result.g.dart';

// Freezed annotation to create a union type for API responses.
@freezed
class Result with _$Result {
  // Factory constructor for a response object.
  const factory Result({
    required bool status, // Indicates the success or failure of the response.
    required dynamic payload, // Holds the result data of the response.
    required String message, // Represents the HTTP status code of the response.
  }) = _Result;

  // Factory method to deserialize a JSON map into a Response object.
  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);
}
