import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/base/base_controller.dart';
import '../../app/base/result_state.dart';
import '../../app/network/exception_handler.dart';
import '../../domain/entities/crew/crew_entity.dart';
import '../../domain/entities/leave/leave_request_entity.dart';
import '../../domain/usecase/get_absences_usecase.dart';
import '../../domain/usecase/get_crew_members_usecase.dart';

/// A view model for the home page that extends the [BaseController].
class HomeViewModel extends BaseController {
  final GetAbsencesUseCase _absencesUseCase;
  final GetCrewMembersUseCase _crewMembersUseCase;

  RxList<CrewMemberEntity> crewList = RxList.empty();
  RxList<LeaveRequestEntity> absenceList = RxList.empty(growable: true);
  List<LeaveRequestEntity> allAbsences = [];

  String? _currentTypeFilter;
  DateTime? _currentDateFilter;
  Map<int, String> idToNameMap = {};

  /// Constructs a [HomeViewModel] with the necessary use cases.
  HomeViewModel(this._absencesUseCase, this._crewMembersUseCase);

  final ScrollController paginationScrollController = ScrollController();

  int currentPage = 1;
  final int pageSize = 10;

  void _onScroll() {
    if (paginationScrollController.position.pixels ==
        paginationScrollController.position.maxScrollExtent) {
      loadMoreAbsence();
    }
  }

  Future<void> prepareMembers() async {
    var membersResult = await _crewMembersUseCase.call();
    membersResult.when(
      success: (data) {
        if (data.message == "Success" && data.payload.isNotEmpty) {
          crewList.addAll(data.payload);
        }
      },
      failure: (ExceptionHandler error) {
        updatePageState(ResultState.error(error: error));
      },
    );
  }

  Future<void> prepareAbsence() async {
    var absenceResult = await _absencesUseCase.call();
    absenceResult.when(
      success: (data) {
        if (data.message == "Success" && data.payload.isNotEmpty) {
          // Store the full list of absences
          allAbsences = data.payload;
          // Initially display the first page of absences
          final endIndex = min(pageSize, allAbsences.length);
          absenceList.addAll(allAbsences.sublist(0, endIndex));
        }
      },
      failure: (ExceptionHandler error) {
        updatePageState(ResultState.error(error: error));
      },
    );
  }

  Future<void> loadMoreAbsence() async {
    if (pageState == const ResultState.loading()) return;
    showLoading();

    final startIndex = currentPage * pageSize;

    if (startIndex < allAbsences.length) {
      final endIndex = min(startIndex + pageSize, allAbsences.length);

      final newItems = allAbsences.sublist(startIndex, endIndex);
      if (newItems.isNotEmpty) {
        absenceList.addAll(newItems);
        currentPage++;
      }
    }

    hideLoading(); // Hide loading indicator after operation
  }


  void _updateUIState() {
    //if below statement be true means application still loading and no error has been thrown
    if (pageState != const ResultState.loading()) return;
    if (crewList.isEmpty && absenceList.isEmpty) {
      updatePageState(const ResultState.empty());
    } else {
      _crewMemberService(crewList);

      hideLoading();
    }
  }

  Future prepareAll() async {
    showLoading();
    try {
      // below delay is just to showing you loading state and performance without is definitely better
      await Future.delayed(const Duration(seconds: 2));
      await Future.wait([prepareMembers(), prepareAbsence()]);
      _updateUIState();
    } on ExceptionHandler catch (error) {
      updatePageState(ResultState.error(error: error));
    }
  }

  @override
  void onInit() async {
    prepareAll();
    paginationScrollController.addListener(_onScroll);
    super.onInit();
  }

  @override
  void dispose() {
    paginationScrollController.dispose();
    super.dispose();
  }

  void _crewMemberService(List<CrewMemberEntity> crewList) {
    idToNameMap = {for (var member in crewList) member.userId: member.name};
  }

  void filterByType(String? type) {
    _currentTypeFilter = type; // Store the current type filter

    if (type == null && _currentDateFilter == null) {
      // If both filters are inactive, reset to the full list
      absenceList.value = List.from(allAbsences);
    } else {
      // Apply both filters to the full list
      absenceList.value = allAbsences.where((entity) {
        final typeMatches = type == null || entity.type.toLowerCase() == type.toLowerCase();
        // Check if _currentDateFilter is not null before calling isAtSameMomentAs
        final dateMatches = _currentDateFilter == null || (entity.startDate.isAtSameMomentAs(_currentDateFilter!));
        return typeMatches && dateMatches;
      }).toList();
    }
  }


  void filterByDate(DateTime? dateTime) {
    _currentDateFilter = dateTime; // Store the current date filter

    if (dateTime == null && _currentTypeFilter == null) {
      // If both filters are inactive, reset to the full list
      absenceList.value = List.from(allAbsences);
    } else {
      // Apply both filters to the full list
      absenceList.value = allAbsences.where((entity) {
        final typeMatches = _currentTypeFilter == null || entity.type.toLowerCase() == _currentTypeFilter!.toLowerCase();
        final dateMatches = dateTime == null || entity.startDate.isAtSameMomentAs(dateTime);
        return typeMatches && dateMatches;
      }).toList();
    }
  }

}
