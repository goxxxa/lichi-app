import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lichi_app/features/catalog/view/catalog_page.dart';
import 'package:lichi_repository/lichi_repository.dart';

class LichiApp extends StatelessWidget {
  const LichiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => LichiRepository(),
      dispose: (repository) => repository.dispose(),
      child: const LichiAppView(),
    );
  }
}

class LichiAppView extends StatelessWidget {
  const LichiAppView({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = GoogleFonts.openSansTextTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white, elevation: 0),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        scaffoldBackgroundColor: Colors.white,
        textTheme: baseTextTheme.copyWith(
          headlineLarge: baseTextTheme.headlineLarge?.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          headlineMedium: baseTextTheme.headlineMedium?.copyWith(
            fontSize: 25,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          headlineSmall: baseTextTheme.headlineSmall?.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          bodyLarge: baseTextTheme.bodyLarge?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          bodyMedium: baseTextTheme.bodyMedium?.copyWith(
            fontSize: 14,
            color: Colors.black54,
          ),
          labelSmall: baseTextTheme.labelSmall?.copyWith(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
      home: const CatalogPage(),
    );
  }
}
