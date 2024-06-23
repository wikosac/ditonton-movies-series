import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:search/data/models/search_response.dart';

import '../../dummy/dummy_objects.dart';
import '../../json_reader.dart';

void main() {
  final tSearchJson = readJson('dummy/search_response.json');
  final tSearchModel = testSearchModel;
  final tSearch = testSearchEntity;
  final tSearchMap = {
    "page": 1,
    "results": [
      {
        "backdrop_path": "/yF1eOkaYvwiORauRCPWznV9xVvi.jpg",
        "id": 298618,
        "original_title": "The Flash",
        "overview": "When his attempt to save his family inadvertently alters the future, Barry Allen becomes trapped in a reality in which General Zod has returned and there are no Super Heroes to turn to. In order to save the world that he is in and return to the future that he knows, Barry's only hope is to race for his life. But will making the ultimate sacrifice be enough to reset the universe?",
        "poster_path": "/rktDFPbfHfUbArZ6OOOKsXcv0Bm.jpg",
        "media_type": "movie",
        "adult": false,
        "title": "The Flash",
        "original_language": "en",
        "genre_ids": [
          28,
          12,
          878
        ],
        "popularity": 263.463,
        "release_date": "2023-06-13",
        "video": false,
        "vote_average": 6.73,
        "vote_count": 3956,
        "original_name": null,
        "name": null,
        "origin_country": [],
        "first_air_date": null
      }
    ],
    "total_pages": 11,
    "total_results": 207
  };

  test('return model from json', () {
    final actual = SearchResponse.fromJson(json.decode(tSearchJson));
    expect(actual, tSearchModel);
  });

  test('return json from model', () {
    final actual = tSearchModel.toJson();
    expect(actual, tSearchMap);
  });

  test('return entity from model', () {
    final actual = tSearchModel.results.map((item) => item.toSearch()).toList();
    expect(actual, [tSearch]);
  });
}
