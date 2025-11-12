import 'package:flutter/widgets.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Товары в данной категории отсутствуют, пожалуйста, выберите другую :(',
      ),
    );
  }
}
