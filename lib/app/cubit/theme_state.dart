part of 'theme_cubit.dart';

class ThemeState {
  final ThemeData theme;
  const ThemeState({required this.theme});

  bool get isDarkMode => theme.brightness == Brightness.dark;

  factory ThemeState.light() => ThemeState(theme: LichiAppTheme.light);
  factory ThemeState.dark() => ThemeState(theme: LichiAppTheme.dark);
}
