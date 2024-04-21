import '../usecase/base/usecase.dart';
import '../../app/base/api_result.dart';
import '../../data/models/leave_request/leave_request_model.dart';
import '../repository/absence_manager_repository.dart';

/// Fetches a list of leave requests.
///
/// This class extends [UseCase] and uses the [AbsenceManagerRepository]
/// to retrieve leave requests, encapsulating the operation in an [ApiResult].
class GetAbsencesUseCase extends UseCase<LeaveRequestsContainer, DateTime?> {

  /// The repository for managing absence data.
  final AbsenceManagerRepository _repository;

  /// Constructs the use case with the required repository.
  GetAbsencesUseCase(this._repository);

  /// Executes the use case to retrieve absence members.
  /// Returns an [ApiResult] with the data or error state.
  @override
  Future<ApiResult<LeaveRequestsContainer>> call({DateTime? params}) => _repository.getLeavesList();
}
