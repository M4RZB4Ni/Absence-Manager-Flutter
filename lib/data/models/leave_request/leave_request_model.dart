import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/leave/leave_request_entity.dart';

part 'leave_request_model.freezed.dart';
part 'leave_request_model.g.dart';

/// Represents a leave request with details about the request status and metadata.
///
/// This class is used to encapsulate all the data related to a leave request,
/// including its creation, confirmation, and rejection details.
@freezed
class LeaveRequest with _$LeaveRequest {
  /// Default constructor for creating a new [LeaveRequest] instance.
  ///
  /// Includes optional parameters for the request's admitter ID, note, and confirmation/rejection dates,
  /// as well as required parameters for creation date, crew ID, end date, ID, start date, type, and user ID.
  const factory LeaveRequest({
    int? admitterId,
    String? admitterNote,
    DateTime? confirmedAt,
    required DateTime createdAt,
    required int crewId,
    required DateTime endDate,
    required int id,
    String? memberNote,
    DateTime? rejectedAt,
    required DateTime startDate,
    required String type,
    required int userId,
  }) = _LeaveRequest;

  /// Creates a [LeaveRequest] from a JSON map.
  ///
  /// Utilizes the generated `_$LeaveRequestFromJson` function to parse the JSON map.
  factory LeaveRequest.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestFromJson(json);
}

/// Converts the [LeaveRequest] instance to a [LeaveRequestEntity].
///
/// This method facilitates the transformation of a data model into a domain entity,
/// aligning with the business logic and use cases of the application.
extension LeaveX on LeaveRequest {
  LeaveRequestEntity toEntity() {
    return LeaveRequestEntity(
        createdAt: createdAt,
        confirmedAt: confirmedAt,
        rejectedAt: rejectedAt,
        crewId: crewId,
        endDate: endDate,
        id: id,
        startDate: startDate,
        type: type,
        admitterNote: admitterNote,
        memberNote: memberNote,
        userId: userId);
  }
}

/// A container class that holds a list of [LeaveRequest] instances and an associated message.
///
/// This class is particularly useful for grouping multiple leave requests together,
/// often used when fetching or displaying a list of requests.
@freezed
class LeaveRequestsContainer with _$LeaveRequestsContainer {
  /// Default constructor for creating a new [LeaveRequestsContainer] instance.
  ///
  /// Requires a message describing the container's contents and a list of [LeaveRequest] instances as payload.
  const factory LeaveRequestsContainer({
    required String message,
    required List<LeaveRequest> payload,
  }) = _LeaveRequestsContainer;

  /// Creates a [LeaveRequestsContainer] from a JSON map.
  ///
  /// Utilizes the generated `_$LeaveRequestsContainerFromJson` function to parse the JSON map.
  factory LeaveRequestsContainer.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestsContainerFromJson(json);
}

/// Converts the [LeaveRequestsContainer] instance to a [LeaveRequestsContainerEntity].
///
/// This method is used to convert the Freezed data model to a domain entity,
/// which represents the business logic of the application.
extension LeaveRequestsContainerX on LeaveRequestsContainer {
  LeaveRequestsContainerEntity toEntity() {
    return LeaveRequestsContainerEntity(
      message: message,
      payload: payload.map((leaveRequest) => leaveRequest.toEntity()).toList(),
    );
  }
}
