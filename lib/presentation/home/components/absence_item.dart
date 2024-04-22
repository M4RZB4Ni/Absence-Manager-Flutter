import 'package:communere/app/resources/app_colors.dart';
import 'package:communere/app/resources/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../domain/entities/leave/leave_request_entity.dart';

class AbsenceItem extends StatelessWidget {
  const AbsenceItem(
      {super.key,
      required this.leaveRequestEntity,
      required this.onExpansionChanged, required this.name});
  final LeaveRequestEntity leaveRequestEntity;
  final ValueChanged<bool> onExpansionChanged;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: key,
        child: ExpansionTile(
            maintainState: true,
            onExpansionChanged: (value) => onExpansionChanged(value),
            title: Text(name),
            subtitle: Text("${AppText.type}: ${leaveRequestEntity.type}"),
            trailing: _statusSituation(leaveRequestEntity),
            children: [
              Text(leaveRequestEntity.admitterNote.toString()),
              const Text("Child 1"),
              const Text("Child 2"),
              const Text("Child 3"),
              const Text("Child 4"),
            ]));
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
