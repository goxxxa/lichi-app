import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichi_api/lichi_api.dart' as lichi_api;
import 'package:lichi_repository/lichi_repository.dart';

part 'clothes.freezed.dart';

@freezed
class Clothes with _$Clothes {
  const factory Clothes({
    required int id,
    required String name,
    required int price,
    required List<ClothesColor> colors,
    required List<Photo> photos,
    required List<ClothesSize> sizes,
  }) = _Clothes;

  factory Clothes.fromApi(lichi_api.Clothes other) {
    final colors = [...other.colors.other, other.colors.current];

    final currentColors = colors.map((t) => ClothesColor.fromApi(t)).toList();

    final currentPhotos = other.photos.map((t) => Photo.fromApi(t)).toList();

    final currentSizes = other.sizes
        .map((t) => ClothesSize.fromApi(t))
        .toList();

    return Clothes(
      id: other.id,
      name: other.name,
      price: other.price,
      colors: currentColors ?? [],
      photos: currentPhotos ?? [],
      sizes: currentSizes ?? [],
    );
  }
}
