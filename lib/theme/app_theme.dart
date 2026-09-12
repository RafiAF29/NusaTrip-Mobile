import 'package:flutter/material.dart';

class AppTheme {
  // Brand Color Palette
  static const Color primary = Color(0xFFC85A32); // Terracotta / Burnt Orange
  static const Color primaryLight = Color(0xFFE07A5F);
  static const Color background = Color(0xFFFDFBF7); // Soft Cream
  static const Color surface = Color(0xFFF5EBE6); // Light Cream Surface
  static const Color darkBrown = Color(0xFF2C1E19); // Text & Dark Accent
  static const Color mutedGreen = Color(0xFF4A6B5D); // Accent Tag
  static const Color cardColor = Colors.white;
  static const Color textMuted = Color(0xFF7A6B63);
  static const Color border = Color(0xFFE8DCD5);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.light(
        primary: primary,
        secondary: primaryLight,
        surface: background,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: darkBrown,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: darkBrown),
        titleTextStyle: TextStyle(
          color: darkBrown,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 2,
        shadowColor: darkBrown.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary, width: 1.5),
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
        hintStyle: const TextStyle(color: textMuted, fontSize: 14),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: darkBrown, fontSize: 32, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(color: darkBrown, fontSize: 22, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: darkBrown, fontSize: 18, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: darkBrown, fontSize: 16),
        bodyMedium: TextStyle(color: textMuted, fontSize: 14),
        bodySmall: TextStyle(color: textMuted, fontSize: 12),
      ),
    );
  }
}
