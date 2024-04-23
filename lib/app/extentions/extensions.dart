import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

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

  String get toNormalDate => substring(0,10);

  /// Get the real image address from the string name of an asset
  String get animation => 'assets/animations/$this.json';

}

extension WriteIcalendarFile on String
{
  Future<File> createCalendarFile(String fileName) async {
    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/$fileName.ics');
    return await file.writeAsString(this);
  }

}

extension JsonFileReaderExtension on String {
  Future<Map<String,dynamic>> readJsonFile() async {
    String content = await DefaultAssetBundle.of(Get.context!).loadString(this);
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
