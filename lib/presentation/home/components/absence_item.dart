import 'package:communere/app/extentions/extensions.dart';
import 'package:communere/app/resources/app_colors.dart';
import 'package:communere/app/resources/app_text.dart';
import 'package:flutter/material.dart';

import '../../../app/extentions/typedefs.dart';
import '../../../domain/entities/leave/leave_request_entity.dart';

class AbsenceItem extends StatelessWidget {
  const AbsenceItem(
      {super.key,
      required this.leaveRequestEntity,
      this.onExpansionChanged,
      required this.name});
  final LeaveRequestEntity leaveRequestEntity;
  final SingleValueCallback? onExpansionChanged;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        leading: IconButton(
            onPressed: () => {}, icon: const Icon(Icons.calendar_today)),
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
