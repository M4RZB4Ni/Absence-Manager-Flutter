// Import necessary packages and files.
import 'package:crewmeister/app/di/main_binding.dart';
import 'package:crewmeister/app/resources/app_text.dart';
import 'package:crewmeister/presentation/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/router/pages.dart';

/// The entry point of the Crewmeister absence manager application.
///
/// This file contains the main function which initializes the Flutter bindings
/// and runs the MyApp widget. It also includes the MyApp widget definition
/// which sets up the application's environment, routes, and localization.
void main() async {
  // Ensure that Flutter bindings are initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  // Run the application with the MyApp widget as the root.
  runApp(const MyApp());
}

/// Represents the root of the application.
///
/// This widget is stateless and builds the application using the GetMaterialApp
/// which provides an environment for internationalization, routing, and dependency
/// injection using the MainBinding class.
class MyApp extends StatelessWidget {
  /// Constructs the MyApp widget.
  const MyApp({super.key});

  /// Builds the application with responsive design and route management.
  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive design.
    return GetMaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      locale: Get.locale, // Set the locale for localization.
      title: AppText.appName, // Set the application title.
      initialBinding:
          MainBinding(), // Use MainBinding for initial setup and dependency injection.
      initialRoute: HomeView.name, // Set the initial route to the HomeScreen.
      getPages:
          AppPages.pages, // Define the application's pages using AppPages.
    );
  }
}
