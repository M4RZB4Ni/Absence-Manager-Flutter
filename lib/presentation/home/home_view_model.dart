import 'dart:math';
import 'package:communere/app/extentions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ical/serializer.dart';
import 'package:open_file/open_file.dart';
import '../../app/base/base_controller.dart';
import '../../app/base/result_state.dart';
import '../../app/network/exception_handler.dart';
import '../../app/resources/app_text.dart';
import '../../domain/entities/crew/crew_entity.dart';
import '../../domain/entities/leave/leave_request_entity.dart';
import '../../domain/usecase/get_absences_usecase.dart';
import '../../domain/usecase/get_crew_members_usecase.dart';

/// A view model for the home page that extends the [BaseController].
///
/// It manages the state and business logic of the home page, handling
/// the retrieval and pagination of crew members and leave requests.
/// This class also provides filtering capabilities and generates iCal files.
class HomeViewModel extends BaseController {

  /// Constructs a [HomeViewModel] with the necessary use cases.
  HomeViewModel(this._absencesUseCase, this._crewMembersUseCase);

  /// Use case for retrieving absences.
  final GetAbsencesUseCase _absencesUseCase;

  /// Use case for retrieving crew members.
  final GetCrewMembersUseCase _crewMembersUseCase;

  /// Reactive list of crew members.
  final RxList<CrewMemberEntity> _crewList = RxList.empty();

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

  /// Calendar object for generating iCal files.
  final ICalendar _cal = ICalendar();

  /// boolean variable to avoid the calling rapidly file generation
  bool _fileProcessStart = false;

  /// Callback for handling scroll events to load more absences.
  void _onScroll() {
    if (paginationScrollController.position.pixels ==
        paginationScrollController.position.maxScrollExtent) {
      _loadMoreAbsence();
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
  Future _prepareAll() async {
    // below delay is just to showing you loading state and performance without is definitely better
    await Future.delayed(const Duration(milliseconds: 2500));
    await Future.wait([_prepareMembers(), _prepareAbsence()]);
    _crewMemberService(_crewList);
  }

  @override
  void onInit() async {
    showLoading();
    _prepareAll();
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

  /// Filters the list of absences based on type and date.
  ///
  /// This function applies the current type and date filters to the full list of absences.
  /// If no filters are set, it resets to the full list of absences. If filters are active,
  /// it applies them and updates the list accordingly. Additionally, it updates the page state
  /// based on whether the filtered list is empty or not.
  void _filterAbsenceList() {
    if (_currentTypeFilter == null && _currentDateFilter == null) {
      // No filters are set, so reset to the full list of absences.
      absenceList.value = List.from(_allAbsences);
    } else {
      // At least one filter is active, so apply it to the full list.
      absenceList.value = _allAbsences.where((entity) {
        // Check if the absence type matches the type filter (if set).
        final typeMatches = _currentTypeFilter == null ||
            entity.type.toLowerCase() == _currentTypeFilter!.toLowerCase();
        // Check if the absence start date matches the date filter (if set).
        final dateMatches = _currentDateFilter == null ||
            entity.startDate.isAtSameMomentAs(_currentDateFilter!);
        // Include the absence in the list if it matches both filters.
        return typeMatches && dateMatches;
      }).toList();
    }
    // Update the page state based on the filtered list's content.
    if (absenceList.isEmpty) {
      // If the filtered list is empty, set the page state to empty.
      updatePageState(const ResultState.empty());
    } else {
      // If the filtered list is not empty, reset the page state to its default.
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
  void generateCalendarFile({required int index}) async {
    if (_fileProcessStart) return;
    _fileProcessStart = true;
    var absenceItem = absenceList[index];
    _cal.addElement(
      IEvent(
        start: absenceItem.startDate,
        end: absenceItem.endDate,
        duration: absenceItem.endDate.difference(absenceItem.startDate),
        organizer:
            IOrganizer(name: fetchNameOfMember(index: index, isAdmitter: true)),
        location: AppText.outOffice,
        description:
            "${AppText.admitterNote}: ${absenceItem.admitterNote} \n ${AppText.memberNote}: ${absenceItem.memberNote}",
        summary:
            '${fetchNameOfMember(index: index)} - ${absenceItem.type.toUpperCase()}',
        rrule: IRecurrenceRule(frequency: IRecurrenceFrequency.DAILY),
      ),
    );
    var file = await _cal.serialize().createCalendarFile("icalFile");
    await OpenFile.open(file.path);
    _fileProcessStart = false;
  }
}
