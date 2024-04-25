
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../result/exception_handler.dart';
import 'base_controller.dart';


abstract class BaseView<Controller extends BaseController>
    extends GetView<Controller> {
  BaseView({super.key});

  final GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  PreferredSizeWidget? appBar(final BuildContext context) => null;

  // You can Override it

  bool safeArea() => true;

  // You can Override it
  bool resizeToAvoidBottomInset() => true;

  bool canPop(final BuildContext context) {
    return true;
  }

  Widget body(final BuildContext context);

  Widget empty() => Container();

  Widget error(ExceptionHandler? e) => Center(child: Text(ExceptionHandler.getErrorMessage(e??const ExceptionHandler.unexpectedError())),);

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
          loading: () => annotatedRegion(context,child: this.loading()),
          data: (final data) => annotatedRegion(context),
          // lostConnection: (widget) => noInternet(),
          error: (error) => annotatedRegion(context,child: this.error(error)),
          empty: () => annotatedRegion(context,child: this.empty()),
        ),
      ),
    );
  }

  Widget noInternetWidget() => const Placeholder();


  Widget annotatedRegion(final BuildContext context, {final Widget? child}) => AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          //Status bar color for android
          statusBarIconBrightness: Brightness.light,
        ),
        child: pageContent(context,child: child),
      );

  Widget pageScaffold(final BuildContext context,{final Widget? child}) => PopScope(
        canPop: false,
        child: Scaffold(
          //sets ios status bar color
          backgroundColor: pageBackgroundColor(context),
          appBar: appBar(context),
          floatingActionButton: floatingActionButton(),
          floatingActionButtonLocation: floatingActionButtonLocation(),
          body: child??body(context),
          bottomNavigationBar: bottomNavigationBar(context),
          drawer: drawer(),
          resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
        ),
      );

  Widget pageContent(final BuildContext context,{final Widget? child}) => safeArea()
      ? SafeArea(
          child: pageScaffold(context,child: child),
        )
      : pageScaffold(context,child: child);

  void showErrorSnackBar(final String message) {
    var snackBar = SnackBar(content: Text(message));
    WidgetsBinding.instance.addPostFrameCallback((final timeStamp) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    });
  }

  Color pageBackgroundColor(BuildContext context) => Theme.of(context).brightness == Brightness.light ?
      ThemeData.light(useMaterial3: true).scaffoldBackgroundColor : ThemeData.dark(useMaterial3: true).colorScheme.background;


  Widget? floatingActionButton() => null;

  Widget? bottomNavigationBar(final BuildContext context) => null;

  Widget? drawer() => null;


  FloatingActionButtonLocation? floatingActionButtonLocation() =>
      FloatingActionButtonLocation.endFloat;


}
