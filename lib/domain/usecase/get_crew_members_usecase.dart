// Importing necessary classes from the application's architecture.
import 'package:crewmeister/domain/entities/crew/crew_entity.dart';

import '../../app/base/api_result.dart';
import '../repository/absence_manager_repository.dart';
import 'base/usecase.dart';

/// Fetches crew members using the provided repository.
///
/// This class extends [UseCase] and uses the [AbsenceManagerRepository]
/// to retrieve leave requests, encapsulating the operation in an [ApiResult].
class GetCrewMembersUseCase extends UseCase<CrewMembersContainerEntity, void> {
  /// Repository for absence management data.
  final AbsenceManagerRepository _repository;

  /// Constructs the use case with the required repository.
  GetCrewMembersUseCase(this._repository);

  /// Executes the use case to retrieve crew members.
  /// Returns an [ApiResult] with the data or error state.
  @override
  Future<ApiResult<CrewMembersContainerEntity>> call({void params}) =>
      _repository.getCrewMemberList();
}
