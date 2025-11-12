import 'package:lichi_api/lichi_api.dart';

abstract class CatalogEvent {}

class LoadInitialProductsData extends CatalogEvent {}

class LoadExactProductsData extends CatalogEvent {
  final String type;

  LoadExactProductsData({required this.type});
}

class LoadMoreData extends CatalogEvent {
  final String type;
  final String page;

  LoadMoreData({required this.type, required this.page});
}

class AddProductToCart extends CatalogEvent {
  final Clothes product;

  AddProductToCart({required this.product});
}

class OpenModalWindow extends CatalogEvent {}

class GetSizes extends CatalogEvent {}
