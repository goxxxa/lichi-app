import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichi_api/lichi_api.dart' as lichi_api;

part 'photo.freezed.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({
    required String big,
    required String medium,
    required String small,
    required String mark,
  }) = _Photo;

  factory Photo.fromApi(lichi_api.Photo otherPhoto) {
    return Photo(
      big: otherPhoto.big,
      medium: otherPhoto.thumbs.medium,
      small: otherPhoto.thumbs.small,
      mark: otherPhoto.meta?.mark ?? '',
    );
  }
}
