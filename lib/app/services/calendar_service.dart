import 'dart:io';

import 'package:ical/serializer.dart';
import 'package:path_provider/path_provider.dart';
import '../../domain/entities/leave/leave_request_entity.dart';
import '../resources/app_text.dart';

class CalendarService {
  /// Internal iCalendar object used for generating iCal files.
  final ICalendar _cal = ICalendar();

  /// Generates an iCal file based on the provided leave request and participant names.
  ///
  /// This method creates an iCalendar event using the details from [absenceItem] and
  /// the names of participants (admitter and member) specified in [names].
  ///
  /// The generated iCalendar event includes start/end times, organizer, location,
  /// description, summary, and recurrence rule.
  ///
  /// Returns a [File] representing the generated iCal file.
  Future<File> generateCalendarFile({
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

    // Get the temporary directory to store the generated iCal file
    final directory = await getTemporaryDirectory();

    // Write the serialized iCalendar data to a file in the temporary directory
    return await File('${directory.path}/icalFile.ics')
        .writeAsString(_cal.serialize());
  }
}
