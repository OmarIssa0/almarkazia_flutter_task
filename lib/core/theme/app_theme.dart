import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData lightTheme = _buildLightTheme();

  static ThemeData _buildLightTheme() {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      primaryContainer: AppColors.primaryDark,
      onPrimaryContainer: AppColors.surface,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      surface: AppColors.surface,
      error: AppColors.error,
    ).copyWith(onSurface: AppColors.text, outline: AppColors.outline, outlineVariant: AppColors.outline, shadow: AppColors.shadow, surfaceContainer: AppColors.surface, surfaceContainerLow: AppColors.background, surfaceContainerHighest: AppColors.surfaceSoft, onSurfaceVariant: AppColors.mutedText);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.background, foregroundColor: AppColors.text, elevation: 0, centerTitle: false, scrolledUnderElevation: 0),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shadowColor: AppColors.shadow,
        surfaceTintColor: AppColors.surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(color: AppColors.outline),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(52),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(color: AppColors.text, fontSize: 30, fontWeight: FontWeight.w800, height: 1.1),
        headlineSmall: TextStyle(color: AppColors.text, fontSize: 24, fontWeight: FontWeight.w800, height: 1.18),
        titleLarge: TextStyle(color: AppColors.text, fontSize: 22, fontWeight: FontWeight.w800, height: 1.15),
        titleMedium: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.w700, height: 1.25),
        titleSmall: TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.w700, height: 1.28),
        bodyLarge: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.w400, height: 1.6),
        bodyMedium: TextStyle(color: AppColors.text, fontSize: 14, fontWeight: FontWeight.w400, height: 1.45),
        bodySmall: TextStyle(color: AppColors.mutedText, fontSize: 12, fontWeight: FontWeight.w500, height: 1.35),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }
}
