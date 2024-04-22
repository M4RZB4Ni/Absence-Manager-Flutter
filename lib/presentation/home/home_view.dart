import 'package:communere/app/base/base_view.dart';
import 'package:communere/app/extentions/extensions.dart';
import 'package:communere/presentation/components/skeleton_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'home_view_model.dart';

class HomeView extends BaseView<HomeViewModel> {
  static String name="/HomeScreen";
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
      child: Lottie.asset('nothing_found'.animation,
          width: Get.width),
    );
  }

  @override
  Widget error() {
    return Center(
      child: Lottie.asset('error'.animation,
          width: 70, height: Get.height * 0.50, fit: BoxFit.fill),
    );
  }
  @override
  Widget body(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(color: Colors.yellow,); // temp widget
        }, separatorBuilder: (context, index) => const Divider(), itemCount: controller.absenceList.length);
  }
}
