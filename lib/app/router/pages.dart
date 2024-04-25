// Class containing static configuration for the app's pages.
import 'package:crewmeister/presentation/home/home_view.dart';
import 'package:get/get.dart';

mixin AppPages {
  // Static constant defining a list of GetPage objects for the app's pages.
  static final pages = [
    GetPage(name: HomeView.name, page: HomeView.new)
  ];
}
