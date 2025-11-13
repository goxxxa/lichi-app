import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LichiAppTheme {
  static final ThemeData light = ThemeData(
    // useMaterial3: false,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        fontFamily: 'Open Sans',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      primary: Colors.black,
      onPrimary: Colors.white,
      secondary: const Color(0xFFF9F9F9),
      onSecondary: const Color.fromARGB(255, 68, 67, 67),
    ),
    textTheme: GoogleFonts.openSansTextTheme().copyWith(
      headlineLarge: GoogleFonts.openSans(
        fontSize: 30,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: 25,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      headlineSmall: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black87,
      ),
      bodyMedium: GoogleFonts.openSans(fontSize: 14, color: Colors.black),
      labelSmall: GoogleFonts.openSans(fontSize: 12, color: Colors.black),
    ),
  );

  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontFamily: 'Open Sans',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF121212),
      surfaceTintColor: Colors.transparent,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white,
      brightness: Brightness.dark,
      surface: Colors.black,
      onSurface: Colors.white,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: const Color.fromARGB(255, 68, 67, 67),
      onSecondary: const Color(0xFFF9F9F9),
    ),
    textTheme: GoogleFonts.openSansTextTheme().copyWith(
      headlineLarge: GoogleFonts.openSans(
        fontSize: 30,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: 25,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headlineSmall: GoogleFonts.openSans(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.openSans(fontSize: 14, color: Colors.white),
      labelSmall: GoogleFonts.openSans(fontSize: 12, color: Colors.white),
    ),
  );
}

class AppStyles {
  static final TextStyle label = GoogleFonts.rubik(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w300,
    fontSize: 14,
    letterSpacing: -0.408,
  );

  static final TextStyle amount = GoogleFonts.rubik(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 30,
    letterSpacing: -0.408,
  );

  static const TextStyle description = TextStyle(
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.w300,
    fontSize: 13,
    height: 1.5,
    letterSpacing: -0.408,
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle descriptionSmall = TextStyle(
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.w300,
    fontSize: 13,
    height: 1.69,
    letterSpacing: -0.408,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.w400,
    fontSize: 30,
    height: 22 / 30,
    letterSpacing: -0.408,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.w400,
    fontSize: 25,
    height: 22 / 25,
    letterSpacing: -0.408,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.w400,
    fontSize: 20,
    height: 22 / 20,
    letterSpacing: -0.408,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 22 / 16,
    letterSpacing: -0.408,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.w300,
    fontSize: 14,
    height: 22 / 14,
    letterSpacing: -0.408,
  );

  static const TextStyle h6 = TextStyle(
    fontFamily: 'Open Sans',
    fontWeight: FontWeight.w300,
    fontSize: 13,
    height: 22 / 13,
    letterSpacing: -0.408,
  );
}
