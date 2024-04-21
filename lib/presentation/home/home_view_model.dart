import 'package:communere/app/base/base_controller.dart';
import 'package:communere/domain/usecase/get_absences_usecase.dart';
import 'package:communere/domain/usecase/get_crew_members_usecase.dart';

/// A view model for the home page that extends the [BaseController].
class HomeViewModel extends BaseController{
  final GetAbsencesUseCase _absencesUseCase;
  final GetCrewMembersUseCase _crewMembersUseCase;

  /// Constructs a [HomeViewModel] with the necessary use cases.
  HomeViewModel(this._absencesUseCase, this._crewMembersUseCase);

}