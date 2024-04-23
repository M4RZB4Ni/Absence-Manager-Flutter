import 'package:flutter/material.dart';

typedef StringSelectionCallback = ValueChanged<String?>;

class StringDropdownWidget extends StatefulWidget {
  final StringSelectionCallback onStringSelected;
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
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedOption,
              icon: const Icon(Icons.arrow_drop_down),
              items: widget.options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue;
                });
                widget.onStringSelected(newValue);
              },
              hint: const Text('Select an option'),
            ),
          ),
          if (_selectedOption != null)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: _resetSelection,
            ),
        ],
      ),
    );
  }
}

