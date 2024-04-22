import 'package:communere/data/data_source/local/absence_manager_local_data_source.dart';
import 'package:communere/data/repository/absence_manager_repository_impl.dart';
import 'package:communere/domain/data_source/absence_manager_data_source.dart';
import 'package:communere/domain/repository/absence_manager_repository.dart';
import 'package:communere/domain/usecase/get_absences_usecase.dart';
import 'package:communere/domain/usecase/get_crew_members_usecase.dart';
import 'package:communere/presentation/home/home_view_model.dart';
import 'package:get/get.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeViewModel>(() => HomeViewModel(
        Get.find<GetAbsencesUseCase>(), Get.find<GetCrewMembersUseCase>()));

    Get.lazyPut<GetAbsencesUseCase>(
        () => GetAbsencesUseCase(Get.find<AbsenceManagerRepository>()));

    Get.lazyPut<GetCrewMembersUseCase>(
        () => GetCrewMembersUseCase(Get.find<AbsenceManagerRepository>()));

    Get.lazyPut<AbsenceManagerRepository>(() =>
        AbsenceManagerRepositoryImpl(Get.find<AbsenceManagerDataSource>()));

    Get.lazyPut<AbsenceManagerDataSource>(
        () => AbsenceManagerLocalDataSource());
  }
}
