// Importing the data source and repository contracts for absence management.
import 'package:communere/data/models/crew/crew_member_model.dart';
import 'package:communere/data/models/leave_request/leave_request_model.dart';

import '../../app/base/api_result.dart';
// Importing domain entities for crew members and leave requests.
import '../../app/network/exception_handler.dart';
import '../../domain/data_source/absence_manager_data_source.dart';
import '../../domain/entities/crew/crew_entity.dart';
import '../../domain/entities/leave/leave_request_entity.dart';
import '../../domain/repository/absence_manager_repository.dart';

/// An implementation of the [AbsenceManagerRepository] that retrieves data from a local data source.
class AbsenceManagerRepositoryImpl implements AbsenceManagerRepository {
  /// The data source from which the repository retrieves absence management data.
  final AbsenceManagerDataSource _dataSource;

  /// Constructs an instance of [AbsenceManagerRepositoryImpl] with the given [AbsenceManagerDataSource].
  AbsenceManagerRepositoryImpl(this._dataSource);

  /// Fetches a list of crew members from the data source and converts it to a domain entity.
  ///
  /// Returns an [ApiResult] containing a [CrewMembersContainerEntity] on success or an error on failure.
  @override
  Future<ApiResult<CrewMembersContainerEntity>> getCrewMemberList() async {
    try {
      final result = await _dataSource.getCrewMemberList();
      return result.when(
        success: (data) {
          if (data.message == "Success" && data.payload.isNotEmpty) {
            return ApiResult.success(data: data.toEntity());
          }
          return const ApiResult.failure(
              error: ExceptionHandler.payloadEmpty());
        },
        failure: (error) => ApiResult.failure(error: error),
      );
    } on Exception catch (e) {
      return ApiResult.failure(
          error: ExceptionHandler.defaultError(e.toString()));
    }
  }

  /// Fetches a list of leave requests from the data source and converts it to a domain entity.
  ///
  /// Returns an [ApiResult] containing a [LeaveRequestsContainerEntity] on success or an error on failure.
  @override
  Future<ApiResult<LeaveRequestsContainerEntity>> getLeavesList() async {
    try {
      final result = await _dataSource.getLeavesList();
      return result.when(
        success: (data) {
          if (data.message == "Success" && data.payload.isNotEmpty) {
            return ApiResult.success(data: data.toEntity());
          }
          return const ApiResult.failure(
              error: ExceptionHandler.payloadEmpty());
        },
        failure: (error) => ApiResult.failure(error: error),
      );
    } on Exception catch (e) {
      return ApiResult.failure(
          error: ExceptionHandler.defaultError(e.toString()));
    }
  }
}
