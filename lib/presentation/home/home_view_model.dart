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

  Future<void> loadMoreAbsence()async
  {
    if(pageState==const ResultState.loading()) return;
    showLoading();
    await prepareAbsence();
    final startIndex = (currentPage - 1) * pageSize;
    final endIndex = startIndex + pageSize;
    final newItems = absenceList.sublist(startIndex, endIndex);
    absenceList.addAll(newItems);
    currentPage++;
  }

  void _updateUIState() {
    if (crewList.isEmpty && absenceList.isEmpty) {
      updatePageState(const ResultState.empty());
    } else {
      updatePageState(
          ResultState.data(data: {'crew': crewList, 'absence': absenceList}));
    }
  }

  Future prepareAll() async {
    showLoading();

    try {
      await Future.wait([prepareMembers(), loadMoreAbsence()]);
      _updateUIState();
    } on ExceptionHandler catch (error) {
      updatePageState(ResultState.error(error: error));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    prepareAll();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

}
