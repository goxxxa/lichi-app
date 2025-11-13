import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/app/cubit/theme_cubit.dart';

class ThemeButtons extends StatelessWidget {
  const ThemeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ThemeCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _themeButton('Темная тема', false, cubit, context)),
        const SizedBox(width: 8),
        Expanded(child: _themeButton('Светлая тема', true, cubit, context)),
      ],
    );
  }
}

Widget _themeButton(
  String text,
  bool dark,
  ThemeCubit cubit,
  BuildContext context,
) {
  return InkWell(
    onTap: () {
      cubit.toggleTheme();
    },
    borderRadius: BorderRadius.circular(20),
    child: Container(
      height: 86,
      decoration: BoxDecoration(
        color: dark
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          dark
              ? Icon(
                  Icons.light_mode,
                  color: dark
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                )
              : Icon(Icons.dark_mode),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: dark
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
