import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/features/cart/bloc/cart_bloc.dart';
import 'package:lichi_app/features/cart/bloc/cart_event.dart';
import 'package:lichi_app/features/cart/cart.dart';
import 'package:lichi_app/ui/ui.dart';

class CartItem extends StatelessWidget {
  final CartModel cartModel;

  const CartItem({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Flexible(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                aspectRatio: 0.75,
                child: Image.network(cartModel.photo, fit: BoxFit.cover),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    cartModel.name,
                    style: AppStyles.h4,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${cartModel.size}',
                  style: AppStyles.h5,
                ),
                const SizedBox(height: 8),
                Text(
                  '${cartModel.price} руб.',
                  style: AppStyles.h4,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.remove, size: 15),
                          ),
                          onTap: () {
                            context.read<CartBloc>().add(
                              DecreaseProductCount(id: cartModel.id),
                            );
                          },
                        ),
                        SizedBox(
                          width: 50,
                          height: 35,
                          child: Center(child: Text('${cartModel.count} ед.')),
                        ),
                        InkWell(
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.add, size: 15),
                          ),
                          onTap: () {
                            context.read<CartBloc>().add(
                              IncreaseProductCount(id: cartModel.id),
                            );
                          },
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<CartBloc>().add(
                          RemoveFromCart(id: cartModel.id),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
