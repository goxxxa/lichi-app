import 'package:lichi_app/features/cart/cart.dart';

abstract class StorageApi {
  const StorageApi();

  Stream<List<CartModel>> get getCartItems;

  Future<List<CartModel>> getAllCartItems();

  Future<void> addToCart(CartModel product);

  Future<void> increaseProductCount(String id);

  Future<void> decreaseProductCount(String id);

  Future<void> deleteFromCart(String id);

  Future<void> close();
}

class CartItemNotFoundException implements Exception {}
