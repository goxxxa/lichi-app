import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichi_app/features/catalog/models/clothes.dart';

part 'cart_model.freezed.dart';

@freezed
class CartModel with _$CartModel {
  const factory CartModel({
    required String id,
    required String name,
    required int price,
    required String photo,
    required String size,
    required int count,
  }) = _CartModel;

  factory CartModel.fromClothes(Clothes other, String size) {
    /// CartModel ID: clothesId_size 
    final id = other.id.toString() + '_' + size;
    return CartModel(
      id: id,
      name: other.name,
      price: other.price,
      photo: other.photos.first.url,
      size: size,
      count: 1,
    );
  }
}
