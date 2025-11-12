import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichi_repository/lichi_repository.dart' as lichi_repository;

part 'photo.freezed.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({required String url}) = _Photo;

  factory Photo.fromRepository(lichi_repository.Photo otherPhoto) {
    return Photo(url: otherPhoto.small);
  }
}
