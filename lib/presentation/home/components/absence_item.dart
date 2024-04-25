import 'package:crewmeister/app/extentions/extensions.dart';
import 'package:crewmeister/app/resources/app_colors.dart';
import 'package:crewmeister/app/resources/app_text.dart';
import 'package:flutter/material.dart';

import '../../../app/extentions/typedefs.dart';
import '../../../domain/entities/leave/leave_request_entity.dart';


/// A widget that displays a single absence item in an expandable format.
///
/// This widget shows the details of a leave request entity and allows users
/// to expand the tile to view more information. It also provides an iCal
/// function to add the event to a calendar.
class AbsenceItem extends StatelessWidget {

  /// Creates an [AbsenceItem] widget.
  ///
  /// Requires [leaveRequestEntity] to display its details, [name] to show
  /// the name associated with the absence, and [iCalFunction] to handle
  /// calendar integration. Optionally, [onExpansionChanged] can be used to
  /// handle the expansion state change.
  const AbsenceItem(
      {super.key,
      required this.leaveRequestEntity,
      this.onExpansionChanged,
      required this.name, required this.iCalFunction});

  /// The leave request entity containing the absence details.
  final LeaveRequestEntity leaveRequestEntity;

  /// Callback for when the expansion state changes.
  final SingleBoolValueCallback? onExpansionChanged;

  /// The name associated with the absence.
  final String name;

  /// Function to execute when the calendar icon is tapped.
  final VoidCallback iCalFunction;

  @override
  Widget build(BuildContext context) {
    // Builds the expansion tile with absence details.
    return ExpansionTile(
        leading: IconButton(
            onPressed: iCalFunction, icon: const Icon(Icons.calendar_today)),
        onExpansionChanged: onExpansionChanged,
        title: Text(name),
        subtitle: Text("${AppText.type}: ${leaveRequestEntity.type}"),
        trailing: _statusSituation(leaveRequestEntity),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                  "${AppText.startDate}: ${leaveRequestEntity.startDate.toString().toNormalDate}"),
              Text(
                  "${AppText.endDate}: ${leaveRequestEntity.endDate.toString().toNormalDate}"),
              Text(
                  "${AppText.duration}: ${leaveRequestEntity.endDate.difference(leaveRequestEntity.startDate).inDays}"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    "${AppText.admitterNote}: ${leaveRequestEntity.admitterNote}"),
                Text("${AppText.memberNote}: ${leaveRequestEntity.memberNote}"),
              ],
            ),
          ),
        ]);
  }


  /// Builds the widget that indicates the status of the leave request.
  ///
  /// It will display different colors and texts depending on whether the
  /// leave request is confirmed, rejected, or still pending
  Widget _statusSituation(LeaveRequestEntity entity) {
    String statusText;
    Color backgroundColor;
    Color textColor;

    if (entity.confirmedAt == null && entity.rejectedAt == null) {
      statusText = AppText.requested;
      backgroundColor = AppColors.infoLight;
      textColor = AppColors.info;
    } else if (entity.confirmedAt == null && entity.rejectedAt != null) {
      statusText = AppText.confirmed;
      backgroundColor = AppColors.successLight;
      textColor = AppColors.success;
    } else {
      statusText = AppText.rejected;
      backgroundColor = AppColors.errorLight;
      textColor = AppColors.error;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        statusText,
        style: TextStyle(color: textColor),
      ),
    );
  }
}
