// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'size.freezed.dart';
part 'size.g.dart';

@freezed
class Size with _$Size {
  const factory Size({
    required String name,
    @JsonKey(defaultValue: 0) required int amount,
    @JsonKey(name: 'amount_real', defaultValue: 0) required int amountReal,
    @JsonKey(defaultValue: true) required bool show,
  }) = _Size;

  factory Size.fromJson(Map<String, Object?> json) => _$SizeFromJson(json);
}
