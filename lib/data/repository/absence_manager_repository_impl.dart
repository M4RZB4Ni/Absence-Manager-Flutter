// Importing the data source and repository contracts for absence management.
import 'package:communere/domain/data_source/absence_manager_data_source.dart';

// Importing core functionality for API results handling.
import '../../app/base/api_result.dart';
// Importing data models for crew members and leave requests.
import '../../domain/repository/absence_manager_repository.dart';
import '../models/crew/crew_member.dart';
import '../models/leave_request/leave_request_model.dart';

/// An implementation of the [AbsenceManagerRepository] that uses a local data source.
class AbsenceManagerRepositoryImpl extends AbsenceManagerRepository {
  /// The data source from which the repository retrieves data.
  final AbsenceManagerDataSource _dataSource;

  /// Constructs an instance of [AbsenceManagerRepositoryImpl] with the given data source.
  AbsenceManagerRepositoryImpl(this._dataSource);

  /// Fetches a list of crew members from the data source.
  /// Returns an [ApiResult] containing a [CrewMembersContainer] on success or an error on failure.
  @override
  Future<ApiResult<CrewMembersContainer>> getCrewMemberList() async {
    return await _dataSource.getCrewMemberList();
  }

  /// Fetches a list of leave requests from the data source.
  /// Returns an [ApiResult] containing a [LeaveRequestsContainer] on success or an error on failure.
  @override
  Future<ApiResult<LeaveRequestsContainer>> getLeavesList() async {
    return await _dataSource.getLeavesList();
  }
}