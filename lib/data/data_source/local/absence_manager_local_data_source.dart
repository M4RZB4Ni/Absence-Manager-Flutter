// Importing necessary packages and extensions.
import 'package:communere/app/extentions/extensions.dart';
import 'package:communere/app/network/exception_handler.dart';

import '../../../app/base/api_result.dart';
import '../../../domain/data_source/absence_manager_data_source.dart';
import '../../models/crew/crew_member.dart';
import '../../models/leave_request/leave_request_model.dart';

/// A local data source class for managing absences, extending the abstract [AbsenceManagerDataSource].
class AbsenceManagerLocalDataSource extends AbsenceManagerDataSource {

  /// Fetches a list of crew members from a local JSON file.
  /// Returns an [ApiResult] containing a [CrewMembersContainer] on success or an error on failure.
  @override
  Future<ApiResult<CrewMembersContainer>> getCrewMemberList() async {
    // Define the path to the local JSON file containing crew member data.
    String path = 'assets/json_files/members.json';
    try {
      // Read the JSON file and parse the result.
      var result = await path.readJsonFile();
      // Return a success result with the parsed data.
      return ApiResult.success(data: CrewMembersContainer.fromJson(result));
    } on Exception catch (e) {
      // In case of an exception, return a failure result with the appropriate error.
      return ApiResult.failure(
          error: ExceptionHandler.jsonDecodingError(exception: e));
    }
  }

  /// Fetches a list of leave requests from a local JSON file.
  /// Returns an [ApiResult] containing a [LeaveRequestsContainer] on success or an error on failure.
  @override
  Future<ApiResult<LeaveRequestsContainer>> getLeavesList() async {
    // Define the path to the local JSON file containing leave request data.
    String path = 'assets/json_files/absences.json';
    try {
      // Read the JSON file and parse the result.
      var result = await path.readJsonFile();
      // Return a success result with the parsed data.
      return ApiResult.success(data: LeaveRequestsContainer.fromJson(result));
    } on Exception catch (e) {
      // In case of an exception, return a failure result with the appropriate error.
      return ApiResult.failure(
          error: ExceptionHandler.jsonDecodingError(exception: e));
    }
  }
}
