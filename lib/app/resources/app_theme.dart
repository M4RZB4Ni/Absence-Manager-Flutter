import 'package:crewmeister/app/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin AppTheme {

  static Brightness mode()
  {
    return Theme.of(Get.context!).brightness;
  }

  static ThemeData light() {
    // Define the light and dark text themes
    const TextTheme lightTextTheme = TextTheme(
      displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: AppColors.primary),
      displayMedium: TextStyle(
          fontSize: 45, fontWeight: FontWeight.w400, color: AppColors.primary),
      displaySmall: TextStyle(
          fontSize: 36, fontWeight: FontWeight.w400, color: AppColors.primary),
      headlineLarge: TextStyle(
          fontSize: 32, fontWeight: FontWeight.w400, color: AppColors.primary),
      headlineMedium: TextStyle(
          fontSize: 28, fontWeight: FontWeight.w400, color: AppColors.primary),
      headlineSmall: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w400, color: AppColors.primary),
      titleLarge: TextStyle(
          fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.primary),
      titleMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary),
      titleSmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary),
      bodyLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.grey900),
      bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grey900),
      bodySmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grey900),
      labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.grey900),
      labelMedium: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.grey900),
      labelSmall: TextStyle(
          fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.grey900),
    );
    return ThemeData(
      brightness: Brightness.light,

      primaryColor: AppColors.primary,
      textTheme: lightTextTheme,
      iconButtonTheme: IconButtonThemeData(style: ButtonStyle(
          // Set the foreground color for the icon button
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            // Return the color for the pressed state
            return AppColors.primaryLight;
          }
          // Return the default color
          return AppColors.primary;
        },
      ))),

      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.teal,
        accentColor: AppColors.secondary,
        backgroundColor: AppColors.background,
        errorColor: AppColors.error,
      ).copyWith(
        secondary: AppColors.secondary,
      ),
      scaffoldBackgroundColor: AppColors.neutral,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: AppColors.onPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
      ),
      // Define other widget themes as needed
    );
  }

  static ThemeData dark() {
    const TextTheme darkTextTheme = TextTheme(
      displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          color: AppColors.onPrimary),
      displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: AppColors.onPrimary),
      displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: AppColors.onPrimary),
      headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          color: AppColors.onPrimary),
      headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          color: AppColors.onPrimary),
      headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: AppColors.onPrimary),
      titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.onPrimary),
      titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.onPrimary),
      titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.onPrimary),
      bodyLarge: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.grey300),
      bodyMedium: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.grey300),
      bodySmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.grey300),
      labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.grey300),
      labelMedium: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.grey300),
      labelSmall: TextStyle(
          fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.grey300),
    );

    return ThemeData(
      textTheme: darkTextTheme,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryDark,

      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.teal,
        accentColor: AppColors.secondaryDark,
        brightness: Brightness.dark,
        backgroundColor: AppColors.grey900,
        errorColor: AppColors.errorLight,
      ).copyWith(
        secondary: AppColors.secondaryDark,
      ),
      scaffoldBackgroundColor: AppColors.grey900,
      iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
        iconColor: MaterialStateProperty.resolveWith<Color>(
            (state) => AppColors.primary),
        // Set the foreground color for the icon button
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              // Return the color for the pressed state
              return AppColors.primaryDark;
            }
            // Return the default color
            return AppColors.primary;
          },
        ),
      )),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryDark,
        iconTheme: IconThemeData(color: AppColors.primary),
        titleTextStyle: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: AppColors.primaryDark),
      ),
      // Define other widget themes as needed
    );
  }
}
