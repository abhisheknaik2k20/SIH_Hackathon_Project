import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryLight = Colors.teal;
  static const Color secondaryLight = Colors.teal;
  static const Color backgroundLight = Colors.white;
  static const Color surfaceLight = Colors.white;
  static const Color errorLight = Color(0xFFB00020);
  static const Color onPrimaryLight = Colors.white;
  static const Color onSecondaryLight = Colors.black;
  static const Color onBackgroundLight = Colors.black;
  static const Color onSurfaceLight = Colors.black;
  static const Color onErrorLight = Colors.white;

  static const Color primaryDark = Colors.teal;
  static const Color secondaryDark = Colors.teal;
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF121212);
  static const Color errorDark = Color(0xFFCF6679);
  static const Color onPrimaryDark = Colors.black;
  static const Color onSecondaryDark = Colors.black;
  static const Color onBackgroundDark = Colors.white;
  static const Color onSurfaceDark = Colors.white;
  static const Color onErrorDark = Colors.black;
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
  useMaterial3: true,
);
