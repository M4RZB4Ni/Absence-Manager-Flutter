import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../result/exception_handler.dart';
import 'base_controller.dart';

/// Abstract base class for views in the application.
/// Subclasses should extend this class and provide their own implementations.
abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> {
  BaseView({super.key});

  // A global key for managing the Scaffold widget state.
  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  /// Override this method to customize the app bar for the view.
  PreferredSizeWidget? appBar(final BuildContext context) => null;

  /// Override this method to control whether a safe area should be applied.
  bool safeArea() => true;

  /// Override this method to control whether the view should resize to avoid the bottom inset.
  bool resizeToAvoidBottomInset() => true;

  /// Determines if the view can be popped from the navigation stack.
  bool canPop(final BuildContext context) {
    return true;
  }

  /// Implement this method to define the main content of the view.
  Widget body(final BuildContext context);

  /// Placeholder widget to display when the view content is empty.
  Widget empty() => Container();

  /// Widget to display when an exception occurs.
  Widget error(ExceptionHandler? e) =>
      Center(child: Text(ExceptionHandler.getErrorMessage(e ?? const ExceptionHandler.unexpectedError())));

  /// Placeholder widget to display while loading data.
  Widget loading() => Container();

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Obx(
            () => controller.pageState.when(
          idle: () => annotatedRegion(context),
          loading: () => annotatedRegion(context, child: this.loading()),
          data: (final data) => annotatedRegion(context),
          // lostConnection: (widget) => noInternet(),
          error: (error) => annotatedRegion(context, child: this.error(error)),
          empty: () => annotatedRegion(context, child: this.empty()),
        ),
      ),
    );
  }

  /// Placeholder widget to display when there is no internet connection.
  Widget noInternetWidget() => const Placeholder();

  /// Wraps the content with an [AnnotatedRegion] to customize system UI overlay styles.
  Widget annotatedRegion(final BuildContext context, {final Widget? child}) => AnnotatedRegion(
    value: const SystemUiOverlayStyle(
      // Status bar color for Android
      statusBarIconBrightness: Brightness.light,
    ),
    child: pageContent(context, child: child),
  );

  /// Wraps the content with a [Scaffold] widget.
  Widget pageScaffold(final BuildContext context, {final Widget? child}) => PopScope(
    canPop: false,
    child: Scaffold(
      // Sets iOS status bar color
      backgroundColor: pageBackgroundColor(context),
      appBar: appBar(context),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: floatingActionButtonLocation(),
      body: child ?? body(context),
      bottomNavigationBar: bottomNavigationBar(context),
      drawer: drawer(),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
    ),
  );

  /// Wraps the content with a [SafeArea] widget if [safeArea] is true.
  Widget pageContent(final BuildContext context, {final Widget? child}) => safeArea()
      ? SafeArea(
    child: pageScaffold(context, child: child),
  )
      : pageScaffold(context, child: child);

  /// Displays a snackbar with the provided error message.
  void showErrorSnackBar(final String message) {
    var snackBar = SnackBar(content: Text(message));
    WidgetsBinding.instance.addPostFrameCallback((final timeStamp) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    });
  }

  /// Determines the background color of the page based on the theme brightness.
  Color pageBackgroundColor(BuildContext context) => Theme.of(context).brightness == Brightness.light
      ? ThemeData.light(useMaterial3: true).scaffoldBackgroundColor
      : ThemeData.dark(useMaterial3: true).colorScheme.surface;

  /// Override this method to provide a custom floating action button.
  Widget? floatingActionButton() => null;

  /// Override this method to provide a custom bottom navigation bar.
  Widget? bottomNavigationBar(final BuildContext context) => null;

  /// Override this method to provide a custom drawer.
  Widget? drawer() => null;

  /// Determines the location of the floating action button.
  FloatingActionButtonLocation? floatingActionButtonLocation() =>
      FloatingActionButtonLocation.endFloat;
}
