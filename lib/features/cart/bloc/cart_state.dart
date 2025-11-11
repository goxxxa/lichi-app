import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichi_api/lichi_api.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.idle() = IdleState;
  const factory CartState.processing() = ProcessingState;
  const factory CartState.loaded(List<Clothes> products) = LoadedState;
  const factory CartState.empty() = EmptyState;
  const factory CartState.error() = ErrorState;
}
