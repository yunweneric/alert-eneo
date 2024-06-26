import 'package:eneo_fails/shared/utils/sizing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class EneoOutageTheme {
  // 1
  static TextTheme lightTextTheme = TextTheme(
    bodyLarge: GoogleFonts.poppins(fontSize: 14.0.sp, fontWeight: FontWeight.w700, color: EneoFailsColor.kDark),
    bodyMedium: GoogleFonts.poppins(fontSize: 14.0.sp, fontWeight: FontWeight.normal, color: EneoFailsColor.kDark),
    displayLarge: GoogleFonts.poppins(fontSize: 28.0.sp, fontWeight: FontWeight.bold, color: EneoFailsColor.kDark),
    displayMedium: GoogleFonts.poppins(fontSize: 23.0.sp, fontWeight: FontWeight.w500, color: EneoFailsColor.kDark),
    displaySmall: GoogleFonts.poppins(fontSize: 14.0.sp, fontWeight: FontWeight.w600, color: EneoFailsColor.kDark),
    titleMedium: GoogleFonts.poppins(fontSize: 16.0.sp, fontWeight: FontWeight.w600, color: EneoFailsColor.kDark),
    labelMedium: TextStyle(fontSize: 14.0.sp, color: EneoFailsColor.kGrey, fontWeight: FontWeight.w300),
  );

  // 2
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.poppins(fontSize: 14.0.sp, fontWeight: FontWeight.w700, color: EneoFailsColor.kWhite),
    bodyMedium: GoogleFonts.poppins(fontSize: 14.0.sp, fontWeight: FontWeight.normal, color: EneoFailsColor.kWhite),
    displayLarge: GoogleFonts.poppins(fontSize: 28.0.sp, fontWeight: FontWeight.bold, color: EneoFailsColor.kWhite),
    displayMedium: GoogleFonts.poppins(fontSize: 23.0.sp, fontWeight: FontWeight.w500, color: EneoFailsColor.kWhite),
    displaySmall: GoogleFonts.poppins(fontSize: 14.0.sp, fontWeight: FontWeight.w600, color: EneoFailsColor.kWhite),
    titleMedium: GoogleFonts.poppins(fontSize: 16.0.sp, fontWeight: FontWeight.w600, color: EneoFailsColor.kWhite),
    labelMedium: TextStyle(fontSize: 14.0.sp, color: EneoFailsColor.kGrey, fontWeight: FontWeight.w300),
  );

  // 3
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: EneoFailsColor.kSuccess,
        primary: EneoFailsColor.kSuccess,
        brightness: Brightness.dark,
        error: EneoFailsColor.kDanger,
        secondary: EneoFailsColor.kSuccess,
      ),
      cardColor: EneoFailsColor.kCard,
      brightness: Brightness.dark,
      primaryColor: EneoFailsColor.kSuccess,
      textTheme: darkTextTheme,
      scaffoldBackgroundColor: EneoFailsColor.kDarkBackground,
      primaryColorDark: EneoFailsColor.kWhite,
      primaryColorLight: EneoFailsColor.kDark,
      shadowColor: Colors.grey,
      bottomAppBarTheme: BottomAppBarTheme(color: EneoFailsColor.kWhite),
      hoverColor: EneoFailsColor.kSuccess,
      listTileTheme: ListTileThemeData(
        contentPadding: kPadding(20.w, 10.h),
        subtitleTextStyle: TextStyle(color: EneoFailsColor.kGrey),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: EneoFailsColor.kSuccess,
        foregroundColor: EneoFailsColor.kDark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: mainBorder(),
        errorBorder: errorBorder(),
        focusedBorder: mainfocusBorder(),
        filled: true,
        fillColor: EneoFailsColor.kGrey.withOpacity(0.15),
        hintStyle: lightTextTheme.labelSmall,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: EneoFailsColor.kDarkBackground,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: EneoFailsColor.kWhite),
        iconTheme: IconThemeData(color: EneoFailsColor.kWhite),
        titleTextStyle: TextStyle(color: EneoFailsColor.kWhite, fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
      cardTheme: CardTheme(
        color: EneoFailsColor.kCard,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: radiusM()),
      ),
    );
  }

  // 4
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: EneoFailsColor.primaryColor,
      textTheme: darkTextTheme,
      colorScheme: ColorScheme.fromSeed(
        seedColor: EneoFailsColor.primaryColor,
        primary: EneoFailsColor.primaryColor,
        brightness: Brightness.dark,
        error: EneoFailsColor.kDanger,
        secondary: EneoFailsColor.kSuccess,
      ),
      cardColor: EneoFailsColor.kDarkCard,
      scaffoldBackgroundColor: EneoFailsColor.kDark,
      primaryColorDark: EneoFailsColor.kWhite,
      primaryColorLight: EneoFailsColor.kDark,
      shadowColor: EneoFailsColor.kDarkCard,
      hoverColor: EneoFailsColor.kSuccess,
      cardTheme: CardTheme(elevation: 0, shape: RoundedRectangleBorder(borderRadius: radiusM())),
      listTileTheme: ListTileThemeData(
        contentPadding: kPadding(20.w, 10.h),
        subtitleTextStyle: TextStyle(color: EneoFailsColor.kGrey),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: EneoFailsColor.primaryColor, foregroundColor: EneoFailsColor.kWhite),
      appBarTheme: AppBarTheme(
        backgroundColor: EneoFailsColor.kDark,
        elevation: 0,
        actionsIconTheme: IconThemeData(color: EneoFailsColor.kWhite),
        iconTheme: IconThemeData(color: EneoFailsColor.kWhite),
        titleTextStyle: TextStyle(color: EneoFailsColor.kWhite, fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
      bottomAppBarTheme: BottomAppBarTheme(color: EneoFailsColor.kDark),
      inputDecorationTheme: InputDecorationTheme(
        border: mainBorder(),
        errorBorder: errorBorder(),
        focusedBorder: mainfocusBorder(),
        filled: true,
        fillColor: EneoFailsColor.kGrey.withOpacity(0.15),
        hintStyle: darkTextTheme.labelSmall,
      ),
    );
  }
}
