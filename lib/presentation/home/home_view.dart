import 'package:communere/app/base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_view_model.dart';

class HomeView extends BaseView<HomeViewModel> {
  HomeView({super.key});

  @override
  Widget body(BuildContext context) {
    return Obx(() => ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Container(); //Temp widget
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: 0,
        ));
  }
}
