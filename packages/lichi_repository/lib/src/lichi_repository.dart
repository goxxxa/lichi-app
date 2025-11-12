import 'package:lichi_api/lichi_api.dart' hide Clothes;
import 'package:lichi_repository/lichi_repository.dart';

class LichiRepository {
  LichiRepository({LichiApiClient? lichiApiClient})
    : _lichiApi = lichiApiClient ?? LichiApiClient();

  final LichiApiClient _lichiApi;

  Future<List<Clothes>> getClothes({
    String category = 'dresses',
    String page = '1',
  }) async {
    try {
      final clothes = await _lichiApi.fetchClothes(
        category: category,
        page: page,
      );
      final currentClothes = clothes.map((t) => Clothes.fromApi(t)).toList();
      return currentClothes;
    } on Exception catch (e) {
      return [];
    }
  }

  void dispose() => _lichiApi.close();
}
