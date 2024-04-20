import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension AppString on String {
  /// Converts a string to a Text Widget
  Text toWidget({TextStyle? textStyle}) => Text(
        this,
        style: textStyle,
      );

  /// Converts the string to an integer value
  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return 0;
    }
  }

  /// Get the real image address from the string name of an asset
  String get animation => 'assets/animations/$this.json';
}

extension JsonFileReaderExtension on String {
  Future<Map<String,dynamic>> readJsonFile() async {
    String content = await File(this).readAsString();
    return jsonDecode(content);
  }
}

extension Reactive on double {
  double toReactive() {
    return r;
  }
}

extension Range on int {
  bool isBetween(num from, num to) {
    return from >= this && this <= to;
  }

  double toReactive() {
    return r;
  }
}
