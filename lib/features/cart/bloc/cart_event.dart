import 'package:lichi_app/features/cart/models/cart_model.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final CartModel clothes;

  AddToCart({required this.clothes});
}

class LoadCartItems extends CartEvent {}

class RemoveFromCart extends CartEvent {
  final String id;

  RemoveFromCart({required this.id});
}

class IncreaseProductCount extends CartEvent {
  final String id;

  IncreaseProductCount({required this.id});
}

class DecreaseProductCount extends CartEvent {
  final String id;

  DecreaseProductCount({required this.id});
}
