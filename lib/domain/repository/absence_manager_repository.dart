// Importing core functionality for API results handling.
import '../../app/base/api_result.dart';

import '../../data/models/crew/crew_member_model.dart';
import '../../data/models/leave_request/leave_request_model.dart';

/// An abstract repository class defining the contract for absence management operations.
abstract class AbsenceManagerRepository {
  /// Retrieves a list of leave requests.
  /// Returns an [ApiResult] containing a [LeaveRequestsContainer] on success or an error on failure.
  Future<ApiResult<LeaveRequestsContainer>> getLeavesList();

  /// Retrieves a list of crew members.
  /// Returns an [ApiResult] containing a [CrewMembersContainer] on success or an error on failure.
  Future<ApiResult<CrewMembersContainer>> getCrewMemberList();
}
