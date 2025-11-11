import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichi_api/src/models/models.dart';

part 'clothes.freezed.dart';

@freezed
class Clothes with _$Clothes {
  const factory Clothes({
    required String name,
    required int price,
    required String description,
    required ClothesColorsList colors,
    required List<Photo> photos,
    required List<Size> sizes,
  }) = _Clothes;

  factory Clothes.fromJson(Map<String, dynamic> json) {
    final photosJson = json['photos'];
    List<Photo> photos = [];

    if (photosJson is List) {
      photos = photosJson
          .map((el) => Photo.fromJson(el as Map<String, dynamic>))
          .where((photo) => photo.meta?.mark == 'model')
          .take(3)
          .toList();
      if (photos.isEmpty) {
        var test = photosJson
            .map((el) => Photo.fromJson(el as Map<String, dynamic>))
            .toList();
        photos = [test[0], test[3], test[5]];
      }
    } else if (photosJson is Map<String, dynamic>) {
      photos = photosJson.values
          .map((el) => Photo.fromJson(el as Map<String, dynamic>))
          .where((photo) => photo.meta?.mark == 'model')
          .take(3)
          .toList();
    }

    final List<Size> sizesList = [];
    final sizesJson = json['sizes'] as Map<String, dynamic>?;

    if (sizesJson != null) {
      sizesJson.forEach((key, sizeData) {
        sizesList.add(Size.fromJson(sizeData));
      });
    }

    final colors = ClothesColorsList.fromJson(
      json['colors'] as Map<String, dynamic>,
    );

    return Clothes(
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      description: json['descriptions']?['text'] ?? '',
      colors: colors,
      photos: photos,
      sizes: sizesList,
    );
  }
}
