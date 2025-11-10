import 'package:bloc/bloc.dart';
import 'package:lichi_api/lichi_api.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_event.dart';
import 'package:lichi_app/features/catalog/bloc/catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final api = LichiApiClient();
  CatalogBloc() : super(const CatalogState.idle()) {
    on<LoadInitialProductsData>((event, emit) async {
      emit(CatalogState.processing());
      final response = await api.fetchProducts();
      if (response.isEmpty) {
        emit(CatalogState.empty());
      }
      emit(CatalogState.loaded(response));
    });
    on<LoadExactProductsData>((event, emit) async {
      emit(CatalogState.processing());
      final response = await api.fetchProducts(type: event.type);
      emit(CatalogState.loaded(response));
    });
  }
}
