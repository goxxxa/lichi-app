import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichi_app/features/catalog/models/photo.dart';
import 'package:lichi_app/features/catalog/models/size.dart';
import 'package:lichi_repository/lichi_repository.dart' as lichi_repository;

part 'clothes.freezed.dart';

@freezed
class Clothes with _$Clothes {
  const factory Clothes({
    required int id,
    required String name,
    required int price,
    required List<Color> colors,
    required List<Photo> photos,
    required List<ClothesSize> sizes,
  }) = _Clothes;

  factory Clothes.fromRepository(lichi_repository.Clothes otherClothes) {
    final colors = otherClothes.colors.map((t) => t.color).toList();
    final photos = otherClothes.photos
        .map((t) => Photo.fromRepository(t))
        .toList();
    final sizes = otherClothes.sizes
        .map((t) => ClothesSize.fromRepository(t))
        .toList();

    return Clothes(
      id: otherClothes.id,
      name: otherClothes.name,
      price: otherClothes.price,
      colors: colors,
      photos: photos,
      sizes: sizes,
    );
  }
}
