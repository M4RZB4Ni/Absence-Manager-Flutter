import 'package:communere/app/resources/app_text.dart';
import 'package:flutter/material.dart';

import '../../app/extentions/typedefs.dart';

/// A custom dropdown widget that allows users to select from a list of string options.
///
/// This widget is stateful to manage the selected option internally and to provide
/// a callback for when the selection changes.
class StringDropdownWidget extends StatefulWidget {

  /// Callback function that is called when a new string is selected.
  final SingleStringValueCallback onStringSelected;

  /// List of string options that the user can select from.
  final List<String> options;

  /// Constructs a [StringDropdownWidget].
  ///
  /// Requires [onStringSelected] to be provided to handle selection changes,
  /// and [options] to display the list of selectable items.
  const StringDropdownWidget({
    super.key,
    required this.onStringSelected,
    required this.options,
  });

  @override
  StringDropdownWidgetState createState() => StringDropdownWidgetState();
}

/// The state class for [StringDropdownWidget].
///
/// It manages the selected option and provides a method to reset the selection.
class StringDropdownWidgetState extends State<StringDropdownWidget> {

  /// The currently selected option, if any.
  String? _selectedOption;

  /// Resets the selected option to null and calls the selection callback.
  void _resetSelection() {
    setState(() {
      _selectedOption = null;
    });
    widget.onStringSelected(null);
  }

  @override
  Widget build(BuildContext context) {

    // Builds the dropdown widget with styling and behavior.
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Dropdown button to display the options.
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedOption,
            icon: const Icon(Icons.arrow_drop_down),
            items:
                widget.options.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value)
                  );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedOption = newValue;
              });
              widget.onStringSelected(newValue);
            },
            hint: const Text(AppText.selectOption),
          ),
        ),

        // Clear button to reset the selection.
        if (_selectedOption != null)
          SizedBox(
            // width: 18,
            // height: 18,
            child: IconButton(
              padding: EdgeInsets.zero,
              // iconSize: 18,
              icon: const Icon(Icons.clear),
              onPressed: _resetSelection,
            ),
          ),
      ],
    );
  }
}
