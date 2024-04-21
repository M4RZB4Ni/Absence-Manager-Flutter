// Importing necessary classes from the application's architecture.
import '../../app/base/api_result.dart';
import '../repository/absence_manager_repository.dart';
import 'base/usecase.dart';
import '../../data/models/crew/crew_member.dart';

/// Fetches crew members using the provided repository.
class GetCrewMembersUseCase extends UseCase<CrewMembersContainer, void> {
  /// Repository for absence management data.
  final AbsenceManagerRepository _repository;

  /// Constructs the use case with the required repository.
  GetCrewMembersUseCase(this._repository);

  /// Executes the use case to retrieve crew members.
  /// Returns an [ApiResult] with the data or error state.
  @override
  Future<ApiResult<CrewMembersContainer>> call({void params}) =>
      _repository.getCrewMemberList();
}