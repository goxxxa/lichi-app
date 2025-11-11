import 'package:freezed_annotation/freezed_annotation.dart';

part 'color.freezed.dart';
part 'color.g.dart';

typedef JsonMap = Map<String, dynamic>;

@freezed
class ClothesColorsList with _$ClothesColorsList {
  const factory ClothesColorsList({
    required ClothesColor current,
    required List<ClothesColor> other,
  }) = _ClothesColorsList;

  factory ClothesColorsList.fromJson(JsonMap json) =>
      _$ClothesColorsListFromJson(json);
}

@freezed
class ClothesColor with _$ClothesColor {
  const factory ClothesColor({required String name, required String value}) =
      _ClothesColor;

  factory ClothesColor.fromJson(JsonMap json) => _$ClothesColorFromJson(json);
}
