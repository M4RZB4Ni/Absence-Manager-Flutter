import '../leave/leave_request_entity.dart';

class LeaveRequestsContainerEntity {
  final String message;
  final List<LeaveRequestEntity> payload;

  LeaveRequestsContainerEntity({
    required this.message,
    required this.payload,
  });
}
