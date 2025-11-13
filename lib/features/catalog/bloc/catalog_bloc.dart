import 'package:bloc/bloc.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_event.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_state.dart';
import 'package:lichi_app/features/catalog/models/clothes.dart';
import 'package:lichi_repository/lichi_repository.dart' hide Clothes;
import 'package:stream_transform/stream_transform.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final LichiRepository _lichiRepository;

  CatalogBloc({required LichiRepository lichiRepository})
    : _lichiRepository = lichiRepository,
      super(const CatalogState.idle()) {
    on<LoadInitialProductsData>(_onLoadInitialData);
    on<LoadExactProductsData>(_onLoadExactData);
    on<LoadMoreData>(
      _onLoadMoreData,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onLoadInitialData(
    LoadInitialProductsData event,
    Emitter<CatalogState> emit,
  ) async {
    emit(const CatalogState.processing());
    try {
      final response = await _lichiRepository.getClothes(category: 'clothes');
      if (response.isEmpty) {
        emit(const CatalogState.empty());
        return;
      }

      final clothes = response.map(Clothes.fromRepository).toList();
      emit(CatalogState.loaded(clothes, 'clothes'));
    } on Exception {
      emit(const CatalogState.error());
    }
  }

  Future<void> _onLoadExactData(
    LoadExactProductsData event,
    Emitter<CatalogState> emit,
  ) async {
    emit(const CatalogState.processing());
    try {
      final response = await _lichiRepository.getClothes(category: event.type);
      final clothes = response.map(Clothes.fromRepository).toList();

      emit(CatalogState.loaded(clothes, event.type));
    } on Exception {
      emit(const CatalogState.error());
    }
  }

  Future<void> _onLoadMoreData(
    LoadMoreData event,
    Emitter<CatalogState> emit,
  ) async {
    try {
      final currentState = state as LoadedState;
      print(currentState.category);
      final response = await _lichiRepository.getClothes(
        category: currentState.category,
        page: event.page,
      );

      final newClothes = response.map(Clothes.fromRepository).toList();

      print(newClothes.length);

      emit(
        currentState.copyWith(
          clothes: [...currentState.clothes, ...newClothes],
          category: currentState.category,
        ),
      );
    } on Exception {
      emit(const CatalogState.error());
    }
  }
}

const throttleDuration = Duration(milliseconds: 300);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) =>
      droppable<E>().call(events.throttle(duration), mapper);
}
