import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichi_api/lichi_api.dart';

part 'catalog_state.freezed.dart';

@freezed
class CatalogState with _$CatalogState {
  const factory CatalogState.idle() = IdleState;
  const factory CatalogState.processing() = ProcessingState;
  const factory CatalogState.loaded(List<Product> products) = LoadedState;
  const factory CatalogState.empty() = EmptyState;
  const factory CatalogState.error() = ErrorState;
}
