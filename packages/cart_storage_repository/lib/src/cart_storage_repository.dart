import 'package:cart_storage_api/local_storage_api.dart';
import 'package:lichi_app/features/cart/models/cart_model.dart';

class CartStorageRepository {
  const CartStorageRepository({required StorageApi storageApi})
    : _storageApi = storageApi;

  final StorageApi _storageApi;

  Stream<List<CartModel>> get getCartItems => _storageApi.getCartItems;

  Future<List<CartModel>> getAllCartItems() => _storageApi.getAllCartItems();

  Future<void> addToCart(CartModel product) => _storageApi.addToCart(product);

  Future<void> increaseProductCount(String id) =>
      _storageApi.increaseProductCount(id);

  Future<void> decreaseProductCount(String id) =>
      _storageApi.decreaseProductCount(id);

  Future<void> deleteFromCart(String id) =>
      _storageApi.decreaseProductCount(id);

  void dispose() => _storageApi.close();
}
