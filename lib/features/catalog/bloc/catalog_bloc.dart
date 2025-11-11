import 'package:bloc/bloc.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_event.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_state.dart';
import 'package:lichi_repository/lichi_repository.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({required LichiRepository lichiRepository})
    : _lichiRepository = lichiRepository,
      super(const CatalogState.idle()) {
    on<LoadInitialProductsData>((event, emit) async {
      emit(CatalogState.processing());
      final response = await _lichiRepository.getClothes();
      print(response);
      if (response.isEmpty) {
        emit(CatalogState.empty());
      }
      emit(CatalogState.loaded(response));
    });
    on<LoadExactProductsData>((event, emit) async {
      emit(CatalogState.processing());
      final response = await _lichiRepository.getClothes(category: event.type);
      emit(CatalogState.loaded(response));
    });
  }
  final LichiRepository _lichiRepository;
}
