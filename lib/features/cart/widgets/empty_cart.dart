import 'package:flutter/widgets.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Корзина пустая \n Добавьте все, что вы хотите.'),
    );
  }
}
