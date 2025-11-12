import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/app/cubit/theme_cubit.dart';
import 'package:lichi_app/features/catalog/view/catalog_page.dart';
import 'package:lichi_app/ui/theme/lichi_app_theme.dart';
import 'package:lichi_repository/lichi_repository.dart';
import 'package:cart_storage_repository/cart_storage_repository.dart';

class LichiApp extends StatelessWidget {
  const LichiApp({super.key, required this.createStorageRepository});

  final CartStorageRepository Function() createStorageRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => createStorageRepository(),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider(
          create: (_) => LichiRepository(),
          dispose: (repository) => repository.dispose(),
        ),
      ],
      child: const LichiAppView(),
    );
  }
}

class LichiAppView extends StatelessWidget {
  const LichiAppView({super.key});

  @override
  Widget build(BuildContext context) {
    // final baseTextTheme = GoogleFonts.openSansTextTheme();
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: LichiAppTheme.light,
            darkTheme: LichiAppTheme.dark,
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: const CatalogPage(),
          );
        },
      ),
    );
  }
}
