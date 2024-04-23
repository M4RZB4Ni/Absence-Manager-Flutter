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
import 'home_view_model.dart';

class HomeView extends BaseView<HomeViewModel> {
  static String name = "/HomeScreen";
  HomeView({super.key});

  @override
  Color pageBackgroundColor() {
    return Colors.white;
  }

  @override
  Widget loading() {
    return const SkeletonList();
  }

  @override
  Widget empty() {
    return Center(
      child: Lottie.asset('nothing_found'.animation, width: Get.width),
    );
  }

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

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text(AppText.appName,
          style: TextStyle(
              fontSize: 13.sp,
              color: AppColors.onPrimary,
              fontFamily: "SharpGrotesk",
              fontWeight: FontWeight.bold)),
      backgroundColor: AppColors.primary,
      actions: [
        Text("${AppText.total}: ${controller.absenceList.length}",
            style: TextStyle(fontSize: 12.sp, color: AppColors.onPrimary)),
        const SizedBox(
          width: 20,
        )
      ],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0.h),
          child: SizedBox(
            height: 40.0.h,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DatePickerWidget(
                  onDateChanged: (value) => controller.filterByDate(value),
                ),
                StringDropdownWidget(
                    onStringSelected: (value) => controller.filterByType(value),
                    options: const ["Sickness", "Vacation",])
              ],
            ),
          )),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() => ListView.separated(
        itemBuilder: (ctx, idx) => AbsenceItem(
              leaveRequestEntity: controller.absenceList[idx],
              onExpansionChanged: (bool value) {
                debugPrint("value--> $value");
              },
              name:
                  controller.idToNameMap[controller.absenceList[idx].userId] ??
                      AppText.unknown,
            ),
        itemCount: controller.absenceList.length,
        separatorBuilder: (BuildContext context, int index) =>
            const Divider()));
  }
}
