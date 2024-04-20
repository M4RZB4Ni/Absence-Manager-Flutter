import '../../app/base/api_result.dart';
import '../../data/models/crew/crew_member.dart';
import '../../data/models/leave_request/leave_request_model.dart';

abstract class AbsenceManagerDataSource{
  Future<ApiResult<LeaveRequestsContainer>> getLeavesList();
  Future<ApiResult<CrewMembersContainer>> getCrewMemberList();
}