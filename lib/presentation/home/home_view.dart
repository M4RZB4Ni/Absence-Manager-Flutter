import 'package:crewmeister/app/base/base_view.dart';
import 'package:crewmeister/presentation/components/date_picker_widget.dart';
import 'package:crewmeister/presentation/components/drop_down_picker_widget.dart';
import 'package:crewmeister/presentation/components/loading_widget.dart';
import 'package:crewmeister/presentation/home/components/absence_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/result/exception_handler.dart';
import '../../app/resources/app_text.dart';
import '../../domain/entities/leave/absence_type.dart';
import '../home/home_view_model.dart';

/// A view representing the home screen of the application.
///
/// This class extends [BaseView] and is responsible for rendering the UI elements
/// of the home page, including loading, empty, and error states, as well as the
/// app bar and body of the page.
class HomeView extends BaseView<HomeViewModel> {
  /// The route name for the home screen.
  static String name = "/HomeScreen";

  /// Constructs a [HomeView] widget.
  HomeView({super.key});

  /// Returns the widget to display when the page is in a loading state.
  @override
  Widget loading() {
    return const LottieWidget(
      name: "searching",
      key: Key("searching"),
    );
  }

  /// Returns the widget to display when the page has no content.
  @override
  Widget empty() {
    return const LottieWidget(
      name: "nothing_found",
    );
  }

  /// Returns the widget to display when the page encounters an error.
  @override
  Widget error(ExceptionHandler? e) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const LottieWidget(name: "error"),
        Text(ExceptionHandler.getErrorMessage(e!))
      ],
    );
  }

  /// Builds the app bar for the home screen.
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        AppText.appName,
      ),
      // backgroundColor: AppColors.primary,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            "${AppText.total}: ${controller.absenceList.length}",
            /*  style: TextStyle(fontSize: 12.sp, color: AppColors.onPrimary)*/
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: Container(
          height: 40.0,
          width: Get.width,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DatePickerWidget(
                onDateChanged: (value) => controller.filterByDate(value),
              ),
              StringDropdownWidget(
                onStringSelected: (value) => controller.filterByType(value),
                options: AbsenceTypeHelper.getStrings(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds the body of the home screen.
  @override
  Widget body(BuildContext context) {
    return ListView.separated(
        controller: controller.paginationScrollController,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (ctx, i) => AbsenceItem(
              leaveRequestEntity: controller.absenceList[i],
              name: controller.fetchNameOfMember(index: i),
              iCalFunction: () => controller.openCalendarFile(index: i),
            ),
        itemCount: controller.absenceList.length,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider());
  }
}
