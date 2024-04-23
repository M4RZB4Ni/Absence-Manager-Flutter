import 'package:communere/app/extentions/extensions.dart';
import 'package:communere/app/resources/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/extentions/typedefs.dart';
import '../../app/resources/app_colors.dart';

class DatePickerWidget extends StatefulWidget {
  final SingleDateValueCallback onDateChanged;

  const DatePickerWidget({super.key, required this.onDateChanged});

  @override
  DatePickerWidgetState createState() => DatePickerWidgetState();
}

class DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _selectedDate;

  void _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.spMin,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color:Theme.of(context).brightness == Brightness.light ?
        ThemeData.light(useMaterial3: true).colorScheme.primary : ThemeData.dark(useMaterial3: true).colorScheme.secondary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.light ? Colors.grey.withOpacity(0.2):Colors.white70.withOpacity(0.2) ,
            spreadRadius: 0.5,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _showDatePicker(context),
              child: Text(
                _selectedDate != null
                    ? _selectedDate.toString().toNormalDate
                    : AppText.tapSelectDate,
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).brightness == Brightness.light ?
                    ThemeData.light(useMaterial3: true).colorScheme.onPrimary : ThemeData.dark(useMaterial3: true).colorScheme.onSecondary),
              ),
            ),
          ),
          if (_selectedDate != null)
            SizedBox(
              width: 18.w,
              height: 18.h,
              child: IconButton(
                iconSize: 18.w,
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.close_outlined,
                    color: AppColors.errorLight),
                onPressed: () {
                  setState(() {
                    _selectedDate = null;
                  });
                  widget.onDateChanged(null);
                },
              ),
            ),
        ],
      ),
    );
  }
}
