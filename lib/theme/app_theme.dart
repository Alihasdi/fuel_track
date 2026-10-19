import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colors taken from the Fuel Track UI/UX design.
class AppColors {
  static const Color maroon = Color(0xFF863752);
  static const Color plum = Color(0xFF5F2A4F);
  static const Color card = Color(0xFFB7B8B7);
  static const Color background = Color(0xFFF3F4F3);
  static const Color text = Color(0xFF2A2A2A);
  static const Color onDark = Color(0xFFF1F1F1);
}

class AppTheme {
  /// Bold Josefin Sans used for the big buttons.
  static TextStyle buttonText(double size) =>
      GoogleFonts.josefinSans(fontSize: size, fontWeight: FontWeight.w700);

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.josefinSans().fontFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.maroon,
        primary: AppColors.maroon,
        secondary: AppColors.plum,
        surface: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
    );

    final textTheme = GoogleFonts.josefinSansTextTheme(base.textTheme).apply(
      bodyColor: AppColors.text,
      displayColor: AppColors.text,
    );

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.text,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: AppColors.text,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.maroon, width: 2),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: AppColors.plum,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
