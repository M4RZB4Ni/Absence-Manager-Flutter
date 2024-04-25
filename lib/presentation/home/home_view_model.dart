import 'dart:math';
import 'package:crewmeister/app/base/base_controller.dart';
import 'package:crewmeister/app/base/result_state.dart';
import 'package:crewmeister/app/resources/app_text.dart';
import 'package:crewmeister/app/result/exception_handler.dart';
import 'package:crewmeister/app/services/calendar_service.dart';
import 'package:crewmeister/domain/entities/crew/crew_entity.dart';
import 'package:crewmeister/domain/entities/leave/leave_request_entity.dart';
import 'package:crewmeister/domain/usecase/get_absences_usecase.dart';
import 'package:crewmeister/domain/usecase/get_crew_members_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

/// A view model for the home page that extends the [BaseController].
///
/// It manages the state and business logic of the home page, handling
/// the retrieval and pagination of crew members and leave requests.
/// This class also provides filtering capabilities and generates iCal files.
class HomeViewModel extends BaseController {

  /// Constructs a [HomeViewModel] with the necessary use cases.
  HomeViewModel(this._absencesUseCase, this._crewMembersUseCase, this._calendarService);

  /// Use case for retrieving absences.
  final GetAbsencesUseCase _absencesUseCase;

  /// Use case for retrieving crew members.
  final GetCrewMembersUseCase _crewMembersUseCase;

  final CalendarService _calendarService;


  /// Reactive list of crew members.
  final List<CrewMemberEntity> _crewList = List.empty(growable: true);

  /// Reactive list of leave requests.
  RxList<LeaveRequestEntity> absenceList = RxList.empty(growable: true);

  /// Full list of leave requests.
  List<LeaveRequestEntity> _allAbsences = [];

  /// Filter for the type of leave.
  String? _currentTypeFilter;

  /// Filter for the date of leave.
  DateTime? _currentDateFilter;

  /// Mapping of crew member IDs to their names.
  Map<int, String> _idToNameMap = {};

  /// Controller for managing scroll events in the UI.
  final ScrollController paginationScrollController = ScrollController();

  /// Current page index for pagination.
  int _currentPage = 1;

  /// Number of items per page.
  final int _pageSize = 10;


  /// Callback for handling scroll events to load more absences.
  void _onScroll() {
    if (paginationScrollController.position.pixels ==
        paginationScrollController.position.maxScrollExtent) {
      // if(_currentTypeFilter==null && _currentDateFilter==null) {
        _loadMoreAbsence();
      // }
    }
  }

  void _handleError(ExceptionHandler error) {
    if (error == const ExceptionHandler.payloadEmpty()) {
      updatePageState(const ResultState.empty());
    } else {
      updatePageState(ResultState.error(error: error));
    }
    debugPrint(ExceptionHandler.getErrorMessage(error));
  }

  /// Prepares the list of crew members by fetching them from the use case.
  Future<void> _prepareMembers() async {
    var membersResult = await _crewMembersUseCase.call();
    membersResult.when(
      success: (data) => _crewList.addAll(data.payload),
      failure: (error) => _handleError(error),
    );
  }

  /// Prepares the list of absences by fetching them from the use case.
  Future<void> _prepareAbsence() async {
    var absenceResult = await _absencesUseCase.call();
    absenceResult.when(
      success: (data) {
        // Store the full list of absences
        _allAbsences = data.payload;
        // Initially display the first page of absences
        final endIndex = min(_pageSize, _allAbsences.length);
        absenceList.addAll(_allAbsences.sublist(0, endIndex));
      },
      failure: (error) => _handleError(error),
    );
  }

  /// Loads more absences when the end of the scroll is reached.
  Future<void> _loadMoreAbsence() async {
    if (pageState == const ResultState.loading()) return;

    final startIndex = _currentPage * _pageSize;

    if (startIndex < _allAbsences.length) {
      final endIndex = min(startIndex + _pageSize, _allAbsences.length);

      final newItems = _allAbsences.sublist(startIndex, endIndex);
      if (newItems.isNotEmpty) {
        absenceList.addAll(newItems);
        _currentPage++;
      }
    }
  }

  /// Prepares all necessary data for the home page.
  Future prepareAll() async {
    // below delay is just to showing you loading state and performance without is definitely better
    await Future.delayed(const Duration(milliseconds: 2500));
    await Future.wait([_prepareMembers(), _prepareAbsence()]);
    _crewMemberService(_crewList);
  }

  @override
  void onInit() {
    showLoading();
    prepareAll();
    paginationScrollController.addListener(_onScroll);
    super.onInit();
  }

  @override
  void dispose() {
    paginationScrollController.dispose();
    super.dispose();
  }

  /// Maps crew member IDs to their names.
  void _crewMemberService(List<CrewMemberEntity> crewList) {
    if (pageState is! Error && pageState != const ResultState.empty()) {
      _idToNameMap = {for (var member in crewList) member.userId: member.name};
      hideLoading();
    }
  }

  /// Filters the list of absences by type.
  void filterByType(String? type) {
    _currentTypeFilter = type; // Store the current type filter
    _filterAbsenceList();
  }

  /// Filters the list of absences by date.
  void filterByDate(DateTime? dateTime) {
    _currentDateFilter = dateTime; // Store the current date filter
    _filterAbsenceList();
  }


  /// Filters the absence list based on the current type and date filters.
  ///
  /// This function applies the current type and date filters to the full list of absences.
  /// If no filters are set, it resets to the first page of absences. If filters are active,
  /// it applies them and updates the list accordingly. It also updates the page state
  /// based on whether the filtered list is empty or not.
  ///
  /// When no filters are applied, the function:
  /// - Resets the current page to 1.
  /// - Clears the existing absence list.
  /// - Adds the first page of absences from the full list to the absence list.
  ///
  /// When filters are applied, the function:
  /// - Filters the full list of absences by the type and date filters.
  /// - Updates the absence list with the filtered results.
  ///
  /// After filtering, the function checks if the absence list is empty:
  /// - If it is, the page state is updated to [ResultState.empty].
  /// - If it is not, the page state is reset to its default state.
  void _filterAbsenceList() {
    if (_currentTypeFilter == null && _currentDateFilter == null) {
      _currentPage = 1;
      absenceList.clear();
      final endIndex = min(_pageSize, _allAbsences.length);
      absenceList.addAll(_allAbsences.sublist(0, endIndex));
    } else {
      absenceList.value = _allAbsences.where((entity) {
        final typeMatches = _currentTypeFilter == null ||
            entity.type.toLowerCase() == _currentTypeFilter!.toLowerCase();
        final dateMatches = _currentDateFilter == null ||
            entity.startDate.isAtSameMomentAs(_currentDateFilter!);
        return typeMatches && dateMatches;
      }).toList();
    }
    if (absenceList.isEmpty) {
      updatePageState(const ResultState.empty());
    } else {
      resetPageState();
    }
  }


  /// Fetches the name of a crew member based on the index and whether they are an admitter.
  String fetchNameOfMember({required int index, bool isAdmitter = false}) {
    return _idToNameMap[isAdmitter
            ? absenceList[index].admitterId
            : absenceList[index].userId] ??
        AppText.unknown;
  }


  /// Generates an iCal file for a specific absence.
  void openCalendarFile({required int index}) async {
    showLoading();
    final names={"admitter":fetchNameOfMember(index: index, isAdmitter: true),"member":fetchNameOfMember(index: index)};
    final file=await _calendarService.generateCalendarFile(absenceItem: absenceList[index], names: names);
    await OpenFile.open(file.path);
    hideLoading();
  }
}
