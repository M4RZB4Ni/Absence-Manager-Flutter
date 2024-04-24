import 'package:communere/app/services/calendar_service.dart';
import 'package:communere/data/data_source/local/absence_manager_local_data_source.dart';
import 'package:communere/data/repository/absence_manager_repository_impl.dart';
import 'package:communere/domain/data_source/absence_manager_data_source.dart';
import 'package:communere/domain/repository/absence_manager_repository.dart';
import 'package:communere/domain/usecase/get_absences_usecase.dart';
import 'package:communere/domain/usecase/get_crew_members_usecase.dart';
import 'package:communere/presentation/home/home_view_model.dart';
import 'package:get/get.dart';
import 'package:ical/serializer.dart';

/// The `MainBinding` class is responsible for setting up and binding all the necessary dependencies
/// for the application using the GetX package.
///
/// It implements the `Bindings` interface which requires the definition of the `dependencies` method.
/// This method will be called automatically by the GetX framework when the corresponding route is navigated to.
class MainBinding implements Bindings {
  /// Overrides the `dependencies` method to define how the dependencies should be created and injected.
  ///
  /// It uses the `Get.lazyPut` method to lazily instantiate the classes only when they are needed.
  /// This is more memory efficient as opposed to eagerly creating instances that may not be immediately required.
  @override
  void dependencies() {
    // Binds the `HomeViewModel` to the dependency injection system.
    // It will find the required use cases (`GetAbsencesUseCase` and `GetCrewMembersUseCase`)
    // and inject them into the `HomeViewModel`.
    Get.lazyPut<HomeViewModel>(() => HomeViewModel(
        Get.find<GetAbsencesUseCase>(),
        Get.find<GetCrewMembersUseCase>(),
        Get.find<CalendarService>()));

    // Binds the `GetAbsencesUseCase` to the dependency injection system.
    // It will find the required repository (`AbsenceManagerRepository`)
    // and inject it into the `GetAbsencesUseCase`.
    Get.lazyPut<GetAbsencesUseCase>(
            () => GetAbsencesUseCase(Get.find<AbsenceManagerRepository>()));

    // Binds the `GetCrewMembersUseCase` to the dependency injection system.
    // It will find the required repository (`AbsenceManagerRepository`)
    // and inject it into the `GetCrewMembersUseCase`.
    Get.lazyPut<GetCrewMembersUseCase>(
            () => GetCrewMembersUseCase(Get.find<AbsenceManagerRepository>()));

    // Binds the `AbsenceManagerRepository` to the dependency injection system.
    // It will find the required data source (`AbsenceManagerDataSource`)
    // and inject it into the `AbsenceManagerRepositoryImpl`.
    Get.lazyPut<AbsenceManagerRepository>(() =>
        AbsenceManagerRepositoryImpl(Get.find<AbsenceManagerDataSource>()));

    // Binds the `AbsenceManagerDataSource` to the dependency injection system.
    // It creates an instance of `AbsenceManagerLocalDataSource` which is presumably
    // the local data handling implementation for absence management.
    Get.lazyPut<AbsenceManagerDataSource>(
            () => AbsenceManagerLocalDataSource());

    // Binds the `ICalendar` to the dependency injection system.
    // It creates an instance of `ICalendar` which is used by the `CalendarServiceImpl`
    // for generating iCalendar events.
    Get.lazyPut<ICalendar>(() => ICalendar());

    // Binds the `CalendarService` to the dependency injection system.
    // It creates an instance of `CalendarServiceImpl` and injects the `ICalendar`
    // instance into it for generating iCal files.
    Get.lazyPut<CalendarService>(
            () => CalendarServiceImpl(Get.find<ICalendar>()));
  }
}
