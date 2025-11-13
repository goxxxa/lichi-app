import 'package:bloc/bloc.dart';
import 'package:cart_storage_repository/cart_storage_repository.dart';
import 'package:lichi_app/features/cart/bloc/cart_event.dart';
import 'package:lichi_app/features/cart/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({required CartStorageRepository storageRepository})
    : _storageRepository = storageRepository,
      super(const CartState.idle()) {
    on<AddToCart>(_onAddToCart);
    on<LoadCartItems>(_onLoadCartItems);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncreaseProductCount>(_onIncreaseProductCount);
    on<DecreaseProductCount>(_onDecreaseProductCount);
  }

  final CartStorageRepository _storageRepository;

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    emit(const CartState.processing());
    try {
      await _storageRepository.addToCart(event.clothes);
    } on Exception {
      emit(const CartState.error());
    }
    final updated = await _storageRepository.getAllCartItems();
    emit(CartState.loaded(updated));
  }

  Future<void> _onLoadCartItems(
    LoadCartItems event,
    Emitter<CartState> emit,
  ) async {
    emit(const CartState.processing());
    try {
      final items = await _storageRepository.getAllCartItems();
      items.isEmpty
          ? emit(const CartState.empty())
          : emit(CartState.loaded(items));
    } on Exception {
      emit(const CartState.error());
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    emit(const CartState.processing());
    try {
      await _storageRepository.deleteFromCart(event.id);
      final updated = await _storageRepository.getAllCartItems();
      updated.isEmpty
          ? emit(const CartState.empty())
          : emit(CartState.loaded(updated));
    } on Exception {
      emit(const CartState.error());
    }
  }

  Future<void> _onIncreaseProductCount(
    IncreaseProductCount event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _storageRepository.increaseProductCount(event.id);
      final items = await _storageRepository.getAllCartItems();
      items.isEmpty
          ? emit(const CartState.empty())
          : emit(CartState.loaded(items));
    } on Exception {
      emit(const CartState.error());
    }
  }

  Future<void> _onDecreaseProductCount(
    DecreaseProductCount event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _storageRepository.decreaseProductCount(event.id);
      final items = await _storageRepository.getAllCartItems();
      items.isEmpty
          ? emit(const CartState.empty())
          : emit(CartState.loaded(items));
    } on Exception {
      emit(const CartState.error());
    }
  }
}
