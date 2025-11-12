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

// class AppTheme {
//   // ===== Цвета =====
//   static const Color lightBackground = Color(0xFFFFFFFF);
//   static const Color darkBackground = Color(0xFF000000);

//   static const Color lightText = Color(0xFF000000);
//   static const Color darkText = Color(0xFFFFFFFF);

//   static const Color accentBlack = Color(0xFF000000);
//   static const Color accentWhite = Color(0xFFFFFFFF);
//   static const Color greyText = Color(0xFF888888);
//   static const Color greyBackground = Color(0xFFF9F9F9);

//   // ===== Текстовые стили =====
//   // Описание
//   static const TextStyle description = TextStyle(
//     fontFamily: 'Open Sans',
//     fontWeight: FontWeight.w300,
//     fontSize: 13,
//     height: 1.5, // line-height 150%
//     letterSpacing: -0.408,
//     color: lightText,
//     textBaseline: TextBaseline.alphabetic,
//   );

//   static const TextStyle descriptionSmall = TextStyle(
//     fontFamily: 'Open Sans',
//     fontWeight: FontWeight.w300,
//     fontSize: 13,
//     height: 1.69, // line-height 169%
//     letterSpacing: -0.408,
//     color: lightText,
//   );

//   // Заголовки
//   static const TextStyle h1 = TextStyle(
//     fontFamily: 'Open Sans',
//     fontWeight: FontWeight.w400,
//     fontSize: 30,
//     height: 22 / 30,
//     letterSpacing: -0.408,
//     color: lightText,
//   );

//   static const TextStyle h2 = TextStyle(
//     fontFamily: 'Open Sans',
//     fontWeight: FontWeight.w400,
//     fontSize: 25,
//     height: 22 / 25,
//     letterSpacing: -0.408,
//     color: lightText,
//   );

//   static const TextStyle h3 = TextStyle(
//     fontFamily: 'Open Sans',
//     fontWeight: FontWeight.w400,
//     fontSize: 20,
//     height: 22 / 20,
//     letterSpacing: -0.408,
//     color: lightText,
//   );

//   static const TextStyle h4 = TextStyle(
//     fontFamily: 'Open Sans',
//     fontWeight: FontWeight.w400,
//     fontSize: 16,
//     height: 22 / 16,
//     letterSpacing: -0.408,
//     color: lightText,
//   );

//   static const TextStyle h5 = TextStyle(
//     fontFamily: 'Open Sans',
//     fontWeight: FontWeight.w300,
//     fontSize: 14,
//     height: 22 / 14,
//     letterSpacing: -0.408,
//     color: lightText,
//   );

//   static const TextStyle h6 = TextStyle(
//     fontFamily: 'Open Sans',
//     fontWeight: FontWeight.w300,
//     fontSize: 13,
//     height: 22 / 13,
//     letterSpacing: -0.408,
//     color: lightText,
//   );

//   // ===== Темы =====
//   static final ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     scaffoldBackgroundColor: lightBackground,
//     primaryColor: accentBlack,
//     appBarTheme: const AppBarTheme(
//       color: lightBackground,
//       iconTheme: IconThemeData(color: lightText),
//       titleTextStyle: h4,
//     ),
//     textTheme: TextTheme(
//       bodyLarge: description,
//       bodyMedium: descriptionSmall,
//       headlineLarge: h1,
//       headlineMedium: h2,
//       headlineSmall: h3,
//       titleLarge: h4,
//       titleMedium: h5,
//       titleSmall: h6,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: accentBlack,
//         foregroundColor: accentWhite,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//       ),
//     ),
//   );

//   static final ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: darkBackground,
//     primaryColor: accentWhite,
//     appBarTheme: const AppBarTheme(
//       color: darkBackground,
//       iconTheme: IconThemeData(color: darkText),
//       titleTextStyle: h4,
//     ),
//     textTheme: TextTheme(
//       bodyLarge: description,
//       bodyMedium: descriptionSmall,
//       headlineLarge: h1,
//       headlineMedium: h2,
//       headlineSmall: h3,
//       titleLarge: h4,
//       titleMedium: h5,
//       titleSmall: h6,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: accentWhite,
//         foregroundColor: accentBlack,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//       ),
//     ),
//   );
// }
