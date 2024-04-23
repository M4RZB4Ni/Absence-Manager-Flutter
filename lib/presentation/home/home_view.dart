import 'package:communere/app/base/base_view.dart';
import 'package:communere/app/extentions/extensions.dart';
import 'package:communere/app/resources/app_colors.dart';
import 'package:communere/presentation/components/date_picker_widget.dart';
import 'package:communere/presentation/components/drop_down_picker_widget.dart';
import 'package:communere/presentation/components/skeleton_list.dart';
import 'package:communere/presentation/home/components/absence_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../app/network/exception_handler.dart';
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

  /// Defines the background color of the page.
  @override
  Color pageBackgroundColor() {
    return Colors.white;
  }

  /// Returns the widget to display when the page is in a loading state.
  @override
  Widget loading() {
    return const SkeletonList();
  }

  /// Returns the widget to display when the page has no content.
  @override
  Widget empty() {
    return Center(
      child: Lottie.asset('nothing_found'.animation, width: Get.width),
    );
  }

  /// Returns the widget to display when the page encounters an error.
  @override
  Widget error(ExceptionHandler? e) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset('error'.animation, fit: BoxFit.fill),
        Text(ExceptionHandler.getErrorMessage(e!))
      ],
    );
  }

  /// Builds the app bar for the home screen.
  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text(
        AppText.appName,
        style: TextStyle(
          fontSize: 13.sp,
          color: AppColors.onPrimary,
          fontFamily: "SharpGrotesk",
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.primary,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            "${AppText.total}: ${controller.allAbsences.length}",
            style: TextStyle(fontSize: 12.sp, color: AppColors.onPrimary),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40.0.h),
        child: Container(
          height: 40.0.h,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
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
    return Obx(() => ListView.separated(
        controller: controller.paginationScrollController,
        itemBuilder: (ctx, i) => AbsenceItem(
              leaveRequestEntity: controller.absenceList[i],
              name: controller.fetchNameOfMember(index: i),
              iCalFunction: () => controller.generateCalendarFile(index: i),
            ),
        itemCount: controller.absenceList.length,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider()));
  }
}
