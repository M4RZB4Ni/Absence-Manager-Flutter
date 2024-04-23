import 'package:communere/app/extentions/extensions.dart';
import 'package:communere/app/resources/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/extentions/typedefs.dart';
import '../../app/resources/app_colors.dart';

class DatePickerWidget extends StatefulWidget {
  final SingleValueCallback onDateChanged;

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
        color: AppColors.onPrimary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
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
                    color: AppColors.primaryDark),
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
