import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichi_api/lichi_api.dart' as lichi_api;

part 'color.freezed.dart';

@freezed
class ClothesColor with _$ClothesColor {
  const factory ClothesColor({required String name, required Color color}) =
      _ClothesColor;

  factory ClothesColor.fromApi(lichi_api.ClothesColor otherColor) {
    final color = Color(int.parse('0xFF${otherColor.value}'));
    return ClothesColor(name: otherColor.name, color: color);
  }
}
