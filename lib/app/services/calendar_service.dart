import 'dart:io';

import 'package:crewmeister/app/base/api_result.dart';
import 'package:crewmeister/app/result/exception_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:ical/serializer.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/leave/leave_request_entity.dart';
import '../resources/app_text.dart';

/// A service interface for generating iCal files based on leave requests.
///
/// This abstract class defines the contract for a calendar service that
/// generates iCalendar files from leave request details.
///
/// Services like CalendarService often require
/// platform-specific features (e.g., file system access on mobile devices).
/// Placing it in the app layer allows direct access to these features
/// without leaking platform dependencies into the domain layer.
abstract class CalendarService {
  /// Generates an iCal file based on the provided leave request and participant names.
  ///
  /// This method creates an iCalendar event using the details from [absenceItem] and
  /// the names of participants (admitter and member) specified in [names].
  ///
  /// The generated iCalendar event includes start/end times, organizer, location,
  /// description, summary, and recurrence rule.
  ///
  /// Returns a [File] representing the generated iCal file.
  Future<ApiResult<File>> generateCalendarFile({
    required LeaveRequestEntity absenceItem,
    required Map<String, String> names,
  });
}

/// Implementation of [CalendarService] that generates iCal files.
///
/// This implementation utilizes an internal [ICalendar] object for generating
/// iCalendar events based on leave request details.
class CalendarServiceImpl extends CalendarService {
  /// Internal iCalendar object used for generating iCal files.
  final ICalendar _cal;

  /// Constructs a [CalendarServiceImpl] with an existing [ICalendar] instance.
  CalendarServiceImpl(this._cal);

  @override
  Future<ApiResult<File>> generateCalendarFile({
    required LeaveRequestEntity absenceItem,
    required Map<String, String> names,
  }) async {
    // Add event details to the iCalendar object
    _cal.addElement(
      IEvent(
        start: absenceItem.startDate,
        end: absenceItem.endDate,
        duration: absenceItem.endDate.difference(absenceItem.startDate),
        organizer: IOrganizer(name: names['admitter']),
        location: AppText.outOffice,
        description:
        "${AppText.admitterNote}: ${absenceItem.admitterNote} \n ${AppText.memberNote}: ${absenceItem.memberNote}",
        summary: '${names['member']} - ${absenceItem.type.toUpperCase()}',
        rrule: IRecurrenceRule(frequency: IRecurrenceFrequency.DAILY),
      ),
    );
    if(!kIsWeb) {
      // Get the temporary directory to store the generated iCal file
      final directory = await getTemporaryDirectory();

      // Write the serialized iCalendar data to a file in the temporary directory
      return ApiResult.success(data: await File('${directory.path}/icalFile.ics')
          .writeAsString(_cal.serialize()));

    }else{
      return const ApiResult.failure(error: ExceptionHandler.defaultError(AppText.notSupport));
    }
  }
}
