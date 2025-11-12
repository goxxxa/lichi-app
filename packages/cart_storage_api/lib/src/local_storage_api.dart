import 'package:rxdart/rxdart.dart';
import 'package:lichi_app/core/database/database.dart';
import 'package:lichi_app/features/cart/cart.dart';

import 'storage_api.dart';

/// An implementation of the [StorageApi] that uses local storage.
class LocalStorageApi extends StorageApi {
  LocalStorageApi({required this.db}) {
    _init();
  }

  final AppDatabase db;

  late final BehaviorSubject<List<CartModel>> _streamController =
      BehaviorSubject<List<CartModel>>.seeded(const []);

  Stream<List<CartModel>> get getCartItems => _streamController.stream;

  Future<void> _init() async {
    final items = await db.select(db.cartItems).get();
    _streamController.add(items.map(_mapEntityToClothes).toList());
  }

  @override
  Future<List<CartModel>> getAllCartItems() async {
    final items = await db.select(db.cartItems).get();
    return items.map(_mapEntityToClothes).toList();
  }

  @override
  Future<void> addToCart(CartModel product) async {
    final current = [..._streamController.value];

    final index = current.indexWhere(
      (item) => item.id == product.id && item.size == product.size,
    );

    if (index != -1) {
      final existing = current[index];
      final updated = existing.copyWith(count: existing.count + 1);
      current[index] = updated;

      final query = db.update(db.cartItems)
        ..where((t) => t.id.equals(product.id));
      await query.write(
        CartItemEntity(
          id: updated.id,
          name: updated.name,
          price: updated.price,
          count: updated.count,
          size: updated.size,
          photo: updated.photo,
        ),
      );
    } else {
      current.add(product);
      await db
          .into(db.cartItems)
          .insert(
            CartItemEntity(
              id: product.id,
              name: product.name,
              price: product.price,
              count: 1,
              size: product.size,
              photo: product.photo,
            ),
          );
    }

    _streamController.add(current);
  }

  @override
  Future<void> deleteFromCart(String id) async {
    await (db.delete(db.cartItems)..where((t) => t.id.equals(id))).go();
    final updated = await getAllCartItems();
    _streamController.add(updated);
  }

  @override
  Future<void> increaseProductCount(String id) async {
    final query = db.update(db.cartItems)..where((t) => t.id.equals(id));
    final item = await (db.select(
      db.cartItems,
    )..where((t) => t.id.equals(id))).getSingleOrNull();

    if (item != null) {
      await query.write(
        CartItemEntity(
          id: item.id,
          name: item.name,
          price: item.price,
          count: item.count + 1,
          size: item.size,
          photo: item.photo,
        ),
      );
      _streamController.add(await getAllCartItems());
    }
  }

  CartModel _mapEntityToClothes(CartItemEntity entity) {
    return CartModel(
      id: entity.id,
      name: entity.name,
      price: entity.price.toInt(),
      photo: entity.photo,
      size: entity.size,
      count: entity.count,
    );
  }

  @override
  Future<void> decreaseProductCount(String id) async {
    final query = db.update(db.cartItems)..where((t) => t.id.equals(id));
    final item = await (db.select(
      db.cartItems,
    )..where((t) => t.id.equals(id))).getSingleOrNull();

    if (item != null) {
      if (item.count > 1) {
        await query.write(
          CartItemEntity(
            id: item.id,
            name: item.name,
            price: item.price,
            count: item.count - 1,
            size: item.size,
            photo: item.photo,
          ),
        );
      } else {
        await (db.delete(db.cartItems)..where((t) => t.id.equals(id))).go();
      }

      _streamController.add(await getAllCartItems());
    }
  }

  void dispose() => _streamController.close();

  @override
  Future<void> close() async {
    _streamController.close();
  }
}
