import 'package:communere/app/resources/app_colors.dart';
import 'package:communere/app/resources/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/extentions/typedefs.dart';

class StringDropdownWidget extends StatefulWidget {
  final SingleStringValueCallback onStringSelected;
  final List<String> options;

  const StringDropdownWidget({
    super.key,
    required this.onStringSelected,
    required this.options,
  });

  @override
  StringDropdownWidgetState createState() => StringDropdownWidgetState();
}

class StringDropdownWidgetState extends State<StringDropdownWidget> {
  String? _selectedOption;

  void _resetSelection() {
    setState(() {
      _selectedOption = null;
    });
    widget.onStringSelected(null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.spMin,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedOption,
              icon: const Icon(Icons.arrow_drop_down),
              items:
                  widget.options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: TextStyle(
                          fontSize: 12.sp, color: AppColors.infoDark)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
                widget.onStringSelected(newValue);
              },
              hint: Text(AppText.selectOption,
                  style:
                      TextStyle(fontSize: 12.sp, color: AppColors.primaryDark)),
            ),
          ),
          if (_selectedOption != null)
            SizedBox(
              width: 18.w,
              height: 18.h,
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 18.w,
                icon: const Icon(Icons.clear),
                onPressed: _resetSelection,
              ),
            ),
        ],
      ),
    );
  }
}
