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
        Expanded(child: _themeButton('Темная тема', false, cubit)),
        const SizedBox(width: 8),
        Expanded(child: _themeButton('Светлая тема', true, cubit)),
      ],
    );
  }
}

Widget _themeButton(String text, bool dark, ThemeCubit cubit) {
  return InkWell(
    onTap: () {
      print('hui');
      cubit.toggleTheme();
    },
    borderRadius: BorderRadius.circular(20),
    child: Container(
      height: 86,
      decoration: BoxDecoration(
        color: dark ? Colors.black : const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          dark
              ? Icon(Icons.light_mode, color: Colors.white)
              : Icon(Icons.dark_mode),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: dark ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
