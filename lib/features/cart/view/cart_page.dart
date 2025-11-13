import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/features/cart/bloc/cart_bloc.dart';
import 'package:lichi_app/features/cart/bloc/cart_state.dart';
import 'package:lichi_app/features/cart/widgets/cart_item.dart';
import 'package:lichi_app/features/cart/widgets/empty_cart.dart';
import 'package:lichi_app/ui/theme/lichi_app_theme.dart';
import 'package:lichi_app/ui/widgets/error_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Корзина'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          return state.when(
            idle: () => const Center(child: CircularProgressIndicator()),
            processing: () => const Center(child: CircularProgressIndicator()),
            loaded: (items) {
              final prices = items.map((t) => t.price * t.count).toList();
              final totalPrice = prices.isNotEmpty
                  ? prices.reduce((a, b) => a + b)
                  : 0;
              return LayoutBuilder(
                builder: (context, constraints) {
                  final estimatedHeight = items.length * 200.0;
                  final isShortList =
                      estimatedHeight < constraints.maxHeight * 0.6;
                  return Stack(
                    children: [
                      CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              return CartItem(cartModel: items[index]);
                            }, childCount: items.length),
                          ),
                          if (!isShortList)
                            SliverToBoxAdapter(
                              child: _BottomPriceBlock(totalPrice: totalPrice),
                            ),
                        ],
                      ),
                      if (isShortList)
                        Positioned(
                          bottom: 60,
                          left: 12,
                          child: _BottomPriceBlock(totalPrice: totalPrice),
                        ),
                    ],
                  );
                },
              );
            },
            empty: () => const EmptyCart(),
            error: () => const ErrorPage(type: 'cart'),
          );
        },
      ),
    );
  }
}

class _BottomPriceBlock extends StatelessWidget {
  final int totalPrice;

  const _BottomPriceBlock({required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('К оплате', style: AppStyles.label),
          const SizedBox(height: 6),
          Text('$totalPrice руб.', style: AppStyles.amount),
        ],
      ),
    );
  }
}
