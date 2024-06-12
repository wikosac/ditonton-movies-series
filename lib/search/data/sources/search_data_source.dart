import 'dart:convert';

import 'package:ditonton/core/errors/exception.dart';
import 'package:ditonton/core/utils/constants.dart';
import 'package:ditonton/search/data/models/search_response.dart';
import 'package:ditonton/search/domain/entities/search.dart';
import 'package:http/http.dart' as http;

class SearchDataSourceImpl implements SearchDataSource {
  @override
  Future<List<Search>> search(String query) async {
    try {
      final url = Uri.parse('$BASE_URL/search/multi?query=$query');
      final response = await http.get(url, headers: HEADERS);

      if (response.statusCode == 200) {
        final data = SearchResponse.fromJson(json.decode(response.body))
            .results
            .map((item) => item.toSearch())
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
