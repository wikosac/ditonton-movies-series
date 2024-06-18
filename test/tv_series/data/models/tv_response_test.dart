import 'dart:convert';

import 'package:ditonton/tv_series/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';
import '../../dummy/dummy_objects.dart';

void main() {
  final tTvJson = readJson('tv_series/dummy/tv_response.json');
  final tTvModel = dummyTvResponse;
  final tTv = dummyTvSeries;
  final tTvMap = {
    "page": 1,
    "results": [
      {
        "adult": false,
        "backdrop_path": "/7cqKGQMnNabzOpi7qaIgZvQ7NGV.jpg",
        "genre_ids": [
          10765,
          10759
        ],
        "id": 76479,
        "origin_country": [
          "US"
        ],
        "original_language": "en",
        "original_name": "The Boys",
        "overview": "A group of vigilantes known informally as \"The Boys\" set out to take down corrupt superheroes with no more than blue-collar grit and a willingness to fight dirty.",
        "popularity": 2783.39,
        "poster_path": "/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg",
        "first_air_date": "2019-07-25",
        "name": "The Boys",
        "vote_average": 8.473,
        "vote_count": 9575
      }
    ],
    "total_pages": 45,
    "total_results": 893
  };

  test('return model from json', () {
    final actual = TvResponse.fromJson(json.decode(tTvJson));
    expect(actual, tTvModel);
  });

  test('return json from model', () {
    final actual = tTvModel.toJson();
    expect(actual, tTvMap);
  });

  test('return entity from model', () {
    final actual = tTvModel.results.map((item) => item.toEntity()).toList();
    expect(actual, [tTv]);
  });
}