import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:lichi_app/ui/theme/lichi_app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(ThemeState(theme: ThemeData.light()));

  void toggleTheme() {
    if (state.isDarkMode) {
      emit(ThemeState.light());
    } else {
      emit(ThemeState.dark());
    }
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    final isDark = json['isDark'] as bool? ?? false;
    return ThemeState(theme: isDark ? ThemeData.dark() : ThemeData.light());
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return {'isDark': state.isDarkMode};
  }
}
