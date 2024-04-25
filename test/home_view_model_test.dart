import 'package:communere/app/base/result_state.dart';
import 'package:communere/app/di/main_binding.dart';
import 'package:communere/app/services/calendar_service.dart';
import 'package:communere/domain/usecase/get_absences_usecase.dart';
import 'package:communere/domain/usecase/get_crew_members_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:communere/presentation/home/home_view_model.dart';

class MockHomeViewModel extends GetxController
    with Mock
    implements HomeViewModel {}

void main() {
  late final HomeViewModel homeViewModel;

  setUpAll(() => {
    WidgetsFlutterBinding.ensureInitialized(),
        MainBinding().dependencies(),
        homeViewModel = HomeViewModel(Get.find<GetAbsencesUseCase>(),
            Get.find<GetCrewMembersUseCase>(), Get.find<CalendarService>())
      });

  group('Home ViewModel', () {

    test('Test Initial Fetching absences', () async {
      expect(homeViewModel.absenceList.isEmpty, true);
      await homeViewModel.prepareAll();
      expect(homeViewModel.absenceList.length, 10);
    });

    test('Test filter absences based on sickness type', () {
      homeViewModel.filterByType("sickness");
      for(var absence in homeViewModel.absenceList){
        expect(absence.type, "sickness");
        expect(absence.type, isNot("vacation"));
      }

    });

    test('Test filter absences based on vacation type', () {
      homeViewModel.filterByType("vacation");
      for(var absence in homeViewModel.absenceList){
        expect(absence.type, "vacation");
        expect(absence.type, isNot("sickness"));
      }
      Get.reset();

    });

    test('Test filter absences based on Date which result on out of range date should be empty',() {
      homeViewModel.filterByDate(DateTime.now());
      expect(homeViewModel.absenceList.isEmpty, true);
    },);

    test('Test filter absences based on Date which result on null value should be empty',() {
      homeViewModel.filterByDate(null);
      expect(homeViewModel.pageState,  anyOf([
          equals(const ResultState.empty()),
          equals(const ResultState.idle()),
      ]));
    },);

  });
}
