// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:lichi_api/lichi_api.dart';

part 'photo.freezed.dart';
part 'photo.g.dart';


@freezed
class Photo with _$Photo {
  const factory Photo({
    required String big,
    required String blurhash,
    required Thumbs thumbs,
    @JsonKey(fromJson: _metaFromJson) Meta? meta,
  }) = _Photo;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
}

@freezed
class Thumbs with _$Thumbs {
  const factory Thumbs({
    @JsonKey(name: '384_512') required String small,
    @JsonKey(name: '768_1024') required String medium,
  }) = _Thumbs;

  factory Thumbs.fromJson(Map<String, dynamic> json) => _$ThumbsFromJson(json);
}

@freezed
class Meta with _$Meta {
  const factory Meta({@JsonKey(name: 'mark') required String? mark}) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

Meta? _metaFromJson(dynamic json) {
  if (json is Map<String, dynamic>) {
    return Meta.fromJson(json);
  }
  return null;
}
