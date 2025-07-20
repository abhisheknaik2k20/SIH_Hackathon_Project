import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryLight = Color(0xFF1A73E8);
  static const Color secondaryLight = Color.fromARGB(255, 215, 107, 0);
  static const Color backgroundLight = Colors.white;
  static const Color surfaceLight = Colors.white;
  static const Color errorLight = Color(0xFFB00020);
  static const Color onPrimaryLight = Colors.white;
  static const Color onSecondaryLight = Colors.black;
  static const Color onBackgroundLight = Colors.black;
  static const Color onSurfaceLight = Colors.black;
  static const Color onErrorLight = Colors.white;

  static const Color primaryDark = Color(0xFF1A73E8);
  static const Color secondaryDark = Color.fromARGB(255, 215, 107, 0);
  static const Color surfaceDark = Color.fromARGB(255, 4, 18, 53);
  static const Color errorDark = Color(0xFFEF4444);
  static const Color onPrimaryDark = Colors.white;
  static const Color onSecondaryDark = Colors.black;
  static const Color onBackgroundDark = Colors.white;
  static const Color onSurfaceDark = Colors.white;
  static const Color onErrorDark = Colors.white;

  // Additional colors for dark theme
  static const Color cardDark = Color(0xFF334155); // For elevated surfaces
  static const Color dividerDark =
      Color(0xFF475569); // For dividers and borders
}

final lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    primary: AppColors.primaryLight,
    secondary: AppColors.secondaryLight,
    surface: AppColors.surfaceLight,
    error: AppColors.errorLight,
    onPrimary: AppColors.onPrimaryLight,
    onSecondary: AppColors.onSecondaryLight,
    onSurface: AppColors.onSurfaceLight,
    onError: AppColors.onErrorLight,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
);

final darkTheme = ThemeData(
  colorScheme: const ColorScheme(
    primary: AppColors.primaryDark,
    secondary: AppColors.secondaryDark,
    surface: AppColors.surfaceDark,
    error: AppColors.errorDark,
    onPrimary: AppColors.onPrimaryDark,
    onSecondary: AppColors.onSecondaryDark,
    onSurface: AppColors.onSurfaceDark,
    onError: AppColors.onErrorDark,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: AppColors.surfaceDark,
  cardColor: AppColors.cardDark,
  dividerColor: AppColors.dividerDark,
  useMaterial3: true,
);
