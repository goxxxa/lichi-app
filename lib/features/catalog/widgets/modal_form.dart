import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/features/cart/bloc/cart_bloc.dart';
import 'package:lichi_app/features/catalog/widgets/catalog_item.dart';
import 'package:lichi_repository/lichi_repository.dart';

class ModalForm extends StatelessWidget {
  final List<ClothesSize> sizes;
  final String price;

  const ModalForm({super.key, required this.sizes, required this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 32, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Выберите размер'),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 22,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${sizes[index].name}'),
                    sizes[index].amount == 0
                        ? const Text('нет в наличии')
                        : const SizedBox(),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) {
              return ColoredBox(
                color: Colors.red,
                child: const SizedBox(height: 24),
              );
            },
            itemCount: sizes.length,
          ),
          const SizedBox(height: 24),
          Text('Как подобрать размер?'),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 0,
              ),
              onPressed: () {
                context.read<CartBloc>();
                Navigator.pop(context);
                showTopSnack(context, 'Товар успешно добавлен в корзину!');
              },
              child: Text(
                'В корзину · ${price}',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
