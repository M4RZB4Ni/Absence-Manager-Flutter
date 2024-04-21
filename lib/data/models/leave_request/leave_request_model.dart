import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/leave/leave_request_entity.dart';

part 'leave_request_model.freezed.dart';
part 'leave_request_model.g.dart';

@freezed
class LeaveRequest with _$LeaveRequest {
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

  factory LeaveRequest.fromJson(Map<String, dynamic> json) => _$LeaveRequestFromJson(json);

  LeaveRequestEntity toEntity() {
    return LeaveRequestEntity(
      admitterId: admitterId,
      admitterNote: admitterNote,
      confirmedAt: confirmedAt,
      createdAt: createdAt,
      crewId: crewId,
      endDate: endDate,
      id: id,
      memberNote: memberNote,
      rejectedAt: rejectedAt,
      startDate: startDate,
      type: type,
      userId: userId,
    );
  }
}

@freezed
class LeaveRequestsContainer with _$LeaveRequestsContainer {
  const factory LeaveRequestsContainer({
    required String message,
    required List<LeaveRequest> payload,
  }) = _LeaveRequestsContainer;

  factory LeaveRequestsContainer.fromJson(Map<String, dynamic> json) => _$LeaveRequestsContainerFromJson(json);

  LeaveRequestsContainerEntity toEntity() {
    return LeaveRequestsContainerEntity(
      message: message,
      payload: payload.map((leaveRequest) => leaveRequest.toEntity()).toList(),
    );
  }

}
