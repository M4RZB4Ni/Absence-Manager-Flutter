import 'package:communere/app/base/base_view.dart';
import 'package:communere/app/extentions/extensions.dart';
import 'package:communere/presentation/components/skeleton_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'home_view_model.dart';

class HomeView extends BaseView<HomeViewModel> {
  static String name="HomeScreen";
  HomeView({super.key});

  @override
  Widget body(BuildContext context) {
    return controller.pageState.when(
      idle: () => Container(),
      loading: () => const SkeletonList(),
      empty: () => Center(
        child: Lottie.asset('nothing_found'.animation,
            width: 70, height: Get.height * 0.50, fit: BoxFit.fill),
      ),
      data: (data) => ListView.separated(
          itemBuilder: (context, index) {
            return Container(); // temp widget
      }, separatorBuilder: (context, index) => const Divider(), itemCount: controller.absenceList.length),
      error: (error) => Center(
        child: Lottie.asset('error'.animation,
            width: 70, height: Get.height * 0.50, fit: BoxFit.fill),
      ),
    );
  }
}
