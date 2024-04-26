import 'dart:convert';
import 'package:flutter/services.dart';

/// Extensions for handling strings, JSON files, and numeric ranges.
extension AppString on String {
  /// Converts a date string to a normal date format (YYYY-MM-DD).
  String get toNormalDate => substring(0, 10);

  /// Generates the real image address from the string name of an asset.
  String get animation => 'assets/animations/$this.json';
}

/// Extensions for reading JSON files.
extension JsonFileReaderExtension on String {
  /// Reads and parses a JSON file from the asset bundle.
  Future<Map<String, dynamic>> readJsonFile() async {
    String content = await rootBundle.loadString(this);
    return jsonDecode(content);
  }
}

/// Extensions for numeric ranges.
extension Range on int {
  /// Checks if the current value is within the specified range.
  bool isBetween(num from, num to) {
    return from >= this && this <= to;
  }
}
