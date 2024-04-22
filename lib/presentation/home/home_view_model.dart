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
  RxList<LeaveRequestEntity> absenceList = RxList.empty();

  /// Constructs a [HomeViewModel] with the necessary use cases.
  HomeViewModel(this._absencesUseCase, this._crewMembersUseCase);

  final ScrollController _scrollController = ScrollController();

  int currentPage = 1;
  final int pageSize = 10;


  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
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
          absenceList.addAll(data.payload);
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
    await prepareAbsence();
    final startIndex = (currentPage - 1) * pageSize;
    // Ensure we don't go out of bounds when slicing the list
    final endIndex = min(startIndex + pageSize, absenceList.length);
    final newItems = absenceList.sublist(startIndex, endIndex);
    if (newItems.isNotEmpty) {
      absenceList.addAll(newItems);
      currentPage++;
    }
    hideLoading(); // Hide loading indicator after operation
  }

  void _updateUIState() {
    //if below statement be true means application still loading and no error has been thrown
    if(pageState!=const ResultState.loading()) return;
    if (crewList.isEmpty && absenceList.isEmpty) {
      updatePageState(const ResultState.empty());
    } else {
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
    _scrollController.addListener(_onScroll);
    super.onInit();

  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

}
