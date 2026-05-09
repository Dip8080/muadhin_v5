import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muaddin/core/utility/app_colors.dart';

ThemeData lightThemeData() {
  return ThemeData(
    // useMaterial3: false,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(backgroundColor: Colors.white),
    iconTheme: IconThemeData(color: Color(0xff4C4C4C), size: 24),
    inputDecorationTheme: const InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      hintStyle: TextStyle(color: AppColors.lightGrey),
      border:  OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.musicTabBorderDark)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightPrimary)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryPurple)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryPurple)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.maxFinite),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: AppColors.lightPrimary,
          foregroundColor: Colors.white),
    ),
    expansionTileTheme: ExpansionTileThemeData(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    textTheme: TextTheme(
      labelLarge: GoogleFonts.outfit(
          color: Color(0xff262626), fontSize: 3.w, fontWeight: FontWeight.w600),
      labelMedium: GoogleFonts.outfit(
          color: AppColors.textGray,
          fontSize: 3.w,
          fontWeight: FontWeight.w400),
      labelSmall: TextStyle(
          color: Color(0xff4C4C4C),
          fontSize: 2.2.w,
          fontFamily: "Outfit",
          fontWeight: FontWeight.w400),
      titleLarge: GoogleFonts.outfit(
          color: Color(0xff262626),
          fontSize: 4.7.w,
          fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.outfit(
          color: Color(0xff262626),
          fontSize: 4.5.w,
          fontWeight: FontWeight.w600),
      titleSmall: GoogleFonts.outfit(
          color: Color(0xff262626), fontSize: 3.w, fontWeight: FontWeight.w600),
      bodyLarge: GoogleFonts.outfit(
          color: Color(0xff262626),
          fontSize: 3.5.w,
          fontWeight: FontWeight.w600),
      bodyMedium: GoogleFonts.outfit(
          color: Colors.white, fontSize: 1.5.w, fontWeight: FontWeight.w200),
      bodySmall: GoogleFonts.outfit(
          color: Color(0xff4C4C4C),
          fontSize: 2.5.w,
          fontWeight: FontWeight.w400),
      headlineLarge: GoogleFonts.outfit(
          color: Colors.white, fontSize: 3.w, fontWeight: FontWeight.w400),
    ),
  );
}
