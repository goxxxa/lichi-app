import 'package:lichi_api/lichi_api.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Clothes product;

  AddToCart({required this.product});
}

class DeleteFromCart extends CartEvent {}

class IncreaseProductCount extends CartEvent {}

class DecreaseProductCount extends CartEvent {}
