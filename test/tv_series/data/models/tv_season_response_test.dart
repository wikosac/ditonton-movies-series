import 'dart:convert';

import 'package:ditonton/tv_series/data/models/tv_season_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';
import '../../dummy/dummy_objects.dart';

void main() {
  final tSeasonJson = readJson('tv_series/dummy/tv_season_response.json');
  final tSeasonModel = dummySeasonResponse;
  final tEpisode = dummyEpisode;
  final tSeasonMap = {
    "_id": "5f647491dbcade003718225d",
    "air_date": "2020-09-10",
    "episodes": [
      {
        "air_date": "2020-09-10",
        "episode_number": 1,
        "episode_type": "standard",
        "id": 2431460,
        "name": "Butcher: A Short Film",
        "overview": "Butcher relives the past, recalling violence and betrayal on the rough road towards finding his wife Becca.",
        "production_code": "",
        "runtime": 5,
        "season_number": 0,
        "show_id": 76479,
        "still_path": "/rWlnk1kYlHtjg75diQLrnY7P9t1.jpg",
        "vote_average": 6.8,
        "vote_count": 4,
        "crew": [],
        "guest_stars": []
      }
    ],
    "name": "Specials",
    "overview": "",
    "id": 163277,
    "poster_path": "/cCXG81dSCPXcqYm6gTHlwtXocti.jpg",
    "season_number": 0,
    "vote_average": 0
  };

  test('return model from json', () {
    final actual = SeasonResponse.fromJson(json.decode(tSeasonJson));
    expect(actual, tSeasonModel);
  });

  test('return json from model', () {
    final actual = tSeasonModel.toJson();
    expect(actual, tSeasonMap);
  });

  test('return entity from model', () {
    final actual = tSeasonModel.episodes.map((item) => item.toEntity()).toList();
    expect(actual, [tEpisode]);
  });
}