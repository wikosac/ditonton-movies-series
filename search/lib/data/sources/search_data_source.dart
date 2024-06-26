import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/io_client.dart';

import '../../domain/entities/search.dart';
import '../models/search_response.dart';

class SearchDataSourceImpl implements SearchDataSource {
  SearchDataSourceImpl({required this.client});

  final IOClient client;

  @override
  Future<List<Search>> search(String query) async {
    try {
      final response = await client
          .get(Uri.parse('$BASE_URL/search/multi?$API_KEY&query=$query'));

      if (response.statusCode == 200) {
        final data = SearchResponse.fromJson(json.decode(response.body))
            .results
            .map((item) => item.toSearch())
            .where((search) => search.type == 'TV' || search.type == 'MOVIE')
            .toList();
        return data;
      } else {
        throw ServerException(message: response.body);
      }
    } on Exception catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}

abstract class SearchDataSource {
  Future<List<Search>> search(String query);
}
