import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichi_repository/lichi_repository.dart' as lichi_repository;

part 'size.freezed.dart';

@freezed
class ClothesSize with _$ClothesSize {
  const factory ClothesSize({required String name, required int amount}) =
      _ClothesSize;

  factory ClothesSize.fromRepository(lichi_repository.ClothesSize otherSize) {
    return ClothesSize(name: otherSize.name, amount: otherSize.amount);
  }
}
