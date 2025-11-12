import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lichi_app/features/cart/models/cart_model.dart';

part 'cart_state.freezed.dart';

@freezed
class CartState with _$CartState {
  const factory CartState.idle() = IdleState;
  const factory CartState.processing() = ProcessingState;
  const factory CartState.loaded(List<CartModel> products) = LoadedState;
  const factory CartState.empty() = EmptyState;
  const factory CartState.error() = ErrorState;
}
