import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lichi_api/lichi_api.dart';

/// Dart API Client which wraps the [Lichi API](https://api.lichi.com).
class LichiApiClient {
  LichiApiClient({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;

  Future<List<Clothes>> fetchClothes({
    String category = 'dresses',
    String page = '1',
  }) async {
    final uri = Uri.https(
      'api.lichi.com',
      '/category/get_category_product_list',
      {
        'shop': '2',
        'lang': '1',
        'category': category,
        'limit': '10',
        'page': page,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final productsJson = jsonBody['api_data']?['aProduct'] as List<dynamic>?;

      if (productsJson != null && productsJson.isNotEmpty) {
        return productsJson
            .map((item) => Clothes.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } else {
      throw ProductRequestFailure();
    }

    return [];
  }

  /// Closes the underlying http client.
  void close() {
    _httpClient.close();
  }
}

/// Exception thrown when lichiSearch fails.
class ProductRequestFailure implements Exception {}

/// Exception thrown when the provided product is not found.
class ProductNotFoundFailure implements Exception {}
