import 'package:flutter/material.dart';

class ThemeButtons extends StatelessWidget {
  const ThemeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: _themeButton('Темная тема', false)),
          const SizedBox(width: 16),
          Expanded(child: _themeButton('Светлая тема', true)),
        ],
      ),
    );
  }
}

Widget _themeButton(String text, bool dark) {
  return InkWell(
    onTap: () {},
    borderRadius: BorderRadius.circular(12),
    child: Container(
      height: 86,
      decoration: BoxDecoration(
        color: dark ? Colors.black : Color.fromARGB(1, 249, 249, 249),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          dark
              ? Icon(Icons.light_mode, color: Colors.white)
              : Icon(Icons.dark_mode),

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
