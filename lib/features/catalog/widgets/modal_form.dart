import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lichi_app/features/cart/bloc/cart_bloc.dart';
import 'package:lichi_app/features/cart/bloc/cart_event.dart';
import 'package:lichi_app/features/cart/models/models.dart';
import 'package:lichi_app/features/catalog/models/clothes.dart';
import 'package:lichi_app/features/catalog/widgets/catalog_card.dart';

class ModalForm extends StatelessWidget {
  final Clothes clothes;
  final ValueNotifier<int?> _selectedIndexNotifier = ValueNotifier<int?>(null);

  ModalForm({super.key, required this.clothes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 32, bottom: 32),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Выберите размер',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: -0.408,
                // color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 8),
            ValueListenableBuilder<int?>(
              valueListenable: _selectedIndexNotifier,
              builder: (context, selectedIndex, _) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: clothes.sizes.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final size = clothes.sizes[index];
                    final isSelected = selectedIndex == index;
                    final isAvailable = size.amount > 0;
                    return GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: isAvailable
                          ? () {
                              if (_selectedIndexNotifier.value == index) {
                                _selectedIndexNotifier.value = null;
                              } else {
                                _selectedIndexNotifier.value = index;
                              }
                            }
                          : null,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              size.name,
                              style: TextStyle(
                                fontFamily: 'Open Sans',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                letterSpacing: -0.408,
                                // color: Colors.black,
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              transitionBuilder: (child, anim) =>
                                  FadeTransition(opacity: anim, child: child),
                              child: isAvailable
                                  ? (isSelected
                                        ? const Icon(
                                            Icons.check_rounded,
                                            // color: Colors.black,
                                            size: 20,
                                          )
                                        : const SizedBox(width: 20, height: 20))
                                  : const Text('нет в наличии'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 24),
            Text('Как подобрать размер?'),
            const SizedBox(height: 32),
            ValueListenableBuilder<int?>(
              valueListenable: _selectedIndexNotifier,
              builder: (context, value, _) => SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedIndexNotifier.value == null
                        ? Colors.grey
                        : Theme.of(context).colorScheme.primary,
                    // foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _selectedIndexNotifier.value != null
                      ? () {
                          final newModel = CartModel.fromClothes(
                            clothes,
                            clothes.sizes[_selectedIndexNotifier.value!].name,
                          );
                          context.read<CartBloc>()
                            ..add(AddToCart(clothes: newModel));
                          Navigator.pop(context);
                          showTopSnack(context);
                        }
                      : null,
                  child: Text(
                    'В корзину · ${clothes.price} ₽',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
