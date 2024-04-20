import '../../app/base/api_result.dart';
import '../../data/models/crew/crew_member.dart';
import '../../data/models/leave_request/leave_request_model.dart';

// Defines an abstract class for absence management data operations.
abstract class AbsenceManagerDataSource {
  /// Retrieves a list of leave requests.
  /// Returns a future of [ApiResult] containing a [LeaveRequestsContainer].
  Future<ApiResult<LeaveRequestsContainer>> getLeavesList();

  /// Retrieves a list of crew members.
  /// Returns a future of [ApiResult] containing a [CrewMembersContainer].
  Future<ApiResult<CrewMembersContainer>> getCrewMemberList();
}
