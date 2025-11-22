// lib/styles/app_style.dart
import 'package:flutter/material.dart';

class AppStyle {
  // Colori
  static const Color primaryColor = Color(0xFF1976D2);
  static const Color secondaryColor = Color(0xFF424242);
  static const Color background = Colors.white;
  static const Color cardColor = Colors.white;
  static const Color textColorLight = Colors.white;
  static const Color textColorDark = Colors.black;

  // Spaziature
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Testi
  static TextStyle headlineMedium = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle bodyMedium = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  // Forme (es. bordi)
  static const RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.zero,
  );

  // Elevazione
  static const double cardElevation = 4.0;
}