import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: AppColors.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.blue,
        secondary: AppColors.teal,
        background: AppColors.lightGrey,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.dark,
        ),
        bodyMedium: TextStyle(fontSize: 14, color: AppColors.grey),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.dark),
      ),
    );
  }
}
