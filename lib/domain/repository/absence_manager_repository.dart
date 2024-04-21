// Importing core functionality for API results handling.
import '../../app/base/api_result.dart';
import '../entities/crew/crew_entity.dart';
import '../entities/leave/leave_request_entity.dart';


/// An abstract repository class defining the contract for absence management operations.
abstract class AbsenceManagerRepository {
  /// Retrieves a list of leave requests.
  /// Returns an [ApiResult] containing a [CrewMembersContainerEntity] on success or an error on failure.
  Future<ApiResult<LeaveRequestsContainerEntity>> getLeavesList();

  /// Retrieves a list of crew members.
  /// Returns an [ApiResult] containing a [CrewMembersContainerEntity] on success or an error on failure.
  Future<ApiResult<CrewMembersContainerEntity>> getCrewMemberList();
}
