import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichi_api/lichi_api.dart' as lichi_api;

part 'size.freezed.dart';

@freezed
class ClothesSize with _$ClothesSize {
  const factory ClothesSize({required String name, required int amount}) =
      _ClothesSize;

  factory ClothesSize.fromApi(lichi_api.Size otherSize) {
    return ClothesSize(name: otherSize.name, amount: otherSize.amount);
  }
}
