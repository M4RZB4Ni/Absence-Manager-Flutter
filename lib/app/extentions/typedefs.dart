import 'package:flutter/material.dart';

/// A set of type definitions for callback functions.
///
/// - [SingleStringValueCallback]: A callback for handling a single string value.
/// - [SingleBoolValueCallback]: A callback for handling a single boolean value.
/// - [SingleDateValueCallback]: A callback for handling a single date value.
typedef SingleStringValueCallback = ValueChanged<String?>;
typedef SingleBoolValueCallback = ValueChanged<bool?>;
typedef SingleDateValueCallback = ValueChanged<DateTime?>;
