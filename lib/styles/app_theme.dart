import 'package:flutter/material.dart';
import 'app_style.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppStyle.primaryColor,
      scaffoldBackgroundColor: AppStyle.background,
      cardColor: AppStyle.cardColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: AppStyle.buttonShape,
          backgroundColor: AppStyle.primaryColor,
          foregroundColor: AppStyle.textColorLight,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: const BorderSide(color: Colors.grey),
        ),
        labelStyle: AppStyle.bodyMedium,
      ),
      textTheme: TextTheme(
        headlineMedium: AppStyle.headlineMedium,
        bodyMedium: AppStyle.bodyMedium,
      ),
    );
  }
  
  // Se in futuro volessi aggiungere un tema scuro:
  // static ThemeData get darkTheme { ... }
}