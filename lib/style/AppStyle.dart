import 'package:flutter/material.dart';
import 'package:todo/style/AppColors.dart';

class AppStyle{
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightPrimary,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      toolbarHeight: 157,
    ),
    scaffoldBackgroundColor: AppColors.lightBackGround,
    textTheme: const TextTheme(
      labelSmall: TextStyle(
        fontSize: 12,
        color: AppColors.labelColor,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    ),

    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.lightPrimary,
        primary: AppColors.lightPrimary,
    )
  );
}