// File: base_controller.dart

import 'package:crewmeister/app/base/result_state.dart'; // Import the ResultState class
import 'package:get/get.dart'; // Import GetX library

/// Abstract base class for controllers in the application.
/// Subclasses should extend this class and provide their own implementations.
abstract class BaseController extends GetxController {
  // A reactive variable to manage the page state using GetX's Rx class.
  final Rx<ResultState?> _pageStateController = const ResultState.idle().obs;

  /// Getter method to retrieve the current page state.
  ResultState get pageState => _pageStateController.value ?? const ResultState.idle();

  /// Method to update the page state.
  void updatePageState(final ResultState state) => _pageStateController(state);

  /// Show a loading state by updating the page state to "loading".
  void showLoading() => updatePageState(const ResultState.loading());

  /// Reset the page state to "idle".
  void resetPageState() => updatePageState(const ResultState.idle());

  /// Hide the loading state by resetting the page state.
  void hideLoading() => resetPageState();
}
